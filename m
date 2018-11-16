Received: from eggs.gnu.org ([2001:4830:134:3::10]:44760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNazn-0002bx-Am
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNazm-0000Za-Dm
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:05:03 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNazm-0000YI-7O
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:05:02 -0500
Received: by mail-ot1-x342.google.com with SMTP id u3so15724202ota.5
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 02:05:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <97c6b0f3-da95-7c99-c478-303544c2990b@redhat.com>
References: <20181016132018.5054-1-vsementsov@virtuozzo.com>
	<20181017095128.GK22755@stefanha-x1.localdomain>
	<CAFEAcA_h8pWjNokWQqUXqLDS=WrtKz-zKQ4QjhjV5UR2Yb8MbQ@mail.gmail.com>
	<97c6b0f3-da95-7c99-c478-303544c2990b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 10:04:41 +0000
Message-ID: <CAFEAcA8B5Ki=qmVGrLvWH4oO6Zaf43_NUAsgwwmCqGqcgj3RAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] migration/block-dirty-bitmap:
 fix Coverity CID1390625
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On 16 November 2018 at 03:28, John Snow <jsnow@redhat.com> wrote:
> I looked again. I think Vladimir's patch will shut up Coverity for sure,
> feel free to apply it if you want this out of your hair.
>
> Stefan suggests the following, however;
>
>
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 5e90f44c2f..00c068fda3 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -284,7 +284,7 @@ static int init_dirty_bitmap_migration(void)
>          const char *drive_name = bdrv_get_device_or_node_name(bs);
>
>          /* skip automatically inserted nodes */
> -        while (bs && bs->drv && bs->implicit) {
> +        while (bs->drv && bs->implicit) {
>              bs = backing_bs(bs);
>          }
>
>
> that by removing the assumption that bs could ever be null here (it
> shouldn't), that we'll coax coverity into not warning anymore. I don't
> know if that will work, because backing_bs can theoretically return NULL
> and might convince coverity there's a problem. In practice it won't be.
>
> I don't know how to check this to see if Stefan's suggestion is appropriate.
>
> For such a small, trivial issue though, just merge this and be done with
> it, in my opinion. If you want to take this fix directly as a "build
> fix" I wouldn't object.

Personally I think the main benefit of this sort of Coverity
warning is that it nudges you to work through and figure out
whether something really can be NULL or not. Stefan's fix
will satisfy Coverity, because what it's complaining about
is that the code in one place assumes a pointer can't be NULL
but in another place does have handling for NULL: it is the
inconsistency that triggers the warning. If backing_bs()
can't return NULL (ie if you would be happy in theory to put
an assert() in after the call) then I think Stefan's fix is
better. If it can return NULL ever then Vladimir's fix is
what you want.

thanks
-- PMM
