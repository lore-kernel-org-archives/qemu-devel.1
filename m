Received: from eggs.gnu.org ([2001:4830:134:3::10]:54937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAEBr-0006gx-FQ
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAEBl-0003lz-N6
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:01:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eAEBl-0003ki-I1
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:01:37 -0400
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112633.10516.44062.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92aa3279-66b5-b765-b36b-2acb6413bd47@redhat.com>
Date: Thu, 2 Nov 2017 13:00:22 +0100
MIME-Version: 1.0
In-Reply-To: <20171031112633.10516.44062.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 17/26] replay: push replay_mutex_lock
 up the call tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 31/10/2017 12:26, Pavel Dovgalyuk wrote:
> +    /* We need to drop the replay_lock so any vCPU threads woken up
> +     * can finish their replay tasks
> +     */
> +    if (replay_mode != REPLAY_MODE_NONE) {
> +        g_assert(replay_mutex_locked());
> +        qemu_mutex_unlock_iothread();
> +        replay_mutex_unlock();
> +        qemu_mutex_lock_iothread();
> +    }

The assert+unlock+lock here is unnecessary; just do

    if (replay_mode != REPLAY_MODE_NONE) {
        replay_mutex_unlock();
    }

which according to a previous suggestion can become just

    replay_mutex_unlock();

>      while (!all_vcpus_paused()) {
>          qemu_cond_wait(&qemu_pause_cond, &qemu_global_mutex);
>          CPU_FOREACH(cpu) {
>              qemu_cpu_kick(cpu);
>          }
>      }
> +
> +    if (replay_mode != REPLAY_MODE_NONE) {
> +        qemu_mutex_unlock_iothread();
> +        replay_mutex_lock();
> +        qemu_mutex_lock_iothread();
> +    }

Likewise, this is not a fast path so:

       qemu_mutex_unlock_iothread();
       if (replay_mode != REPLAY_MODE_NONE) {
           replay_mutex_lock();
       }
       qemu_mutex_lock_iothread();

or, applying the same previous suggestion,

       /* Unlock iothread to preserve lock hierarchy.  */
       qemu_mutex_unlock_iothread();
       replay_mutex_lock();
       qemu_mutex_lock_iothread();

Paolo
