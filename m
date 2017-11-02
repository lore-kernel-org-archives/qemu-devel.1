Received: from eggs.gnu.org ([2001:4830:134:3::10]:41795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eADfp-000547-Vy
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eADfl-0003sP-36
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:28:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eADfk-0003ri-TE
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:28:33 -0400
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112542.10516.61105.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f87350f-2a29-ae49-c86a-63bc8c425937@redhat.com>
Date: Thu, 2 Nov 2017 12:28:25 +0100
MIME-Version: 1.0
In-Reply-To: <20171031112542.10516.61105.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 08/26] replay: make safe vmstop at
 record/replay
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

On 31/10/2017 12:25, Pavel Dovgalyuk wrote:
>  
> -    bdrv_drain_all();
> -    replay_disable_events();
> -    ret = bdrv_flush_all();
> +    if (!replay_events_enabled()) {
> +        bdrv_drain_all();
> +        ret = bdrv_flush_all();
> +    }
>  
>      return ret;
>  }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 20cebe1..41a13c0 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2143,8 +2143,8 @@ int save_snapshot(const char *name, Error **errp)
>      AioContext *aio_context;
>  
>      if (!replay_can_snapshot()) {
> -        monitor_printf(mon, "Record/replay does not allow making snapshot "
> -                        "right now. Try once more later.\n");
> +        error_report("Record/replay does not allow making snapshot "
> +                     "right now. Try once more later.\n");

Why this change?

Paolo

>          return ret;
