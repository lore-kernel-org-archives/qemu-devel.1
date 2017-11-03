Received: from eggs.gnu.org ([2001:4830:134:3::10]:55987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eAY5i-0004jV-Dq
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eAY5d-0000Cp-FI
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:16:42 -0400
Received: from mail.ispras.ru ([83.149.199.45]:40490)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eAY5d-0000CN-8R
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:16:37 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112633.10516.44062.stgit@pasha-VirtualBox>
	<92aa3279-66b5-b765-b36b-2acb6413bd47@redhat.com>
In-Reply-To: <92aa3279-66b5-b765-b36b-2acb6413bd47@redhat.com>
Date: Fri, 3 Nov 2017 12:16:39 +0300
Message-ID: <001301d35484$75071110$5f153330$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
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
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 31/10/2017 12:26, Pavel Dovgalyuk wrote:
> > +    /* We need to drop the replay_lock so any vCPU threads woken up
> > +     * can finish their replay tasks
> > +     */
> > +    if (replay_mode != REPLAY_MODE_NONE) {
> > +        g_assert(replay_mutex_locked());
> > +        qemu_mutex_unlock_iothread();
> > +        replay_mutex_unlock();
> > +        qemu_mutex_lock_iothread();
> > +    }
> 
> The assert+unlock+lock here is unnecessary; just do
> 
>     if (replay_mode != REPLAY_MODE_NONE) {
>         replay_mutex_unlock();
>     }
> 
> which according to a previous suggestion can become just
> 
>     replay_mutex_unlock();

We can't remove qemu_mutex_unlock_iothread(), because there is an assert
inside replay_mutex_unlock(), which checks that iothread is unlocked.

> 
> >      while (!all_vcpus_paused()) {
> >          qemu_cond_wait(&qemu_pause_cond, &qemu_global_mutex);
> >          CPU_FOREACH(cpu) {
> >              qemu_cpu_kick(cpu);
> >          }
> >      }
> > +
> > +    if (replay_mode != REPLAY_MODE_NONE) {
> > +        qemu_mutex_unlock_iothread();
> > +        replay_mutex_lock();
> > +        qemu_mutex_lock_iothread();
> > +    }
> 

Pavel Dovgalyuk
