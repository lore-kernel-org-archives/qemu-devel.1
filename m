Received: from eggs.gnu.org ([209.51.188.92]:48349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2cjH-0007Qo-K4
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2cjF-0007MW-9V
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:13:34 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2cjC-0007KJ-Dp
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:13:32 -0500
Received: by mail-oi1-x243.google.com with SMTP id j10so331377oij.13
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 06:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20190307095441.31921-1-kraxel@redhat.com>
	<20190307095441.31921-4-kraxel@redhat.com>
	<CAFEAcA_HzSj7sQ+aKEwHmJXkJcG8yLmn5ZsZKM5xxYUrBxO2rQ@mail.gmail.com>
	<jpg36nxf8ta.fsf@linux.bootlegged.copy>
	<jpg8sxpypx2.fsf_-_@linux.bootlegged.copy>
In-Reply-To: <jpg8sxpypx2.fsf_-_@linux.bootlegged.copy>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2019 14:13:18 +0000
Message-ID: <CAFEAcA_3=cQDHibDe++d+6UpkHhKMP8=s4iJYbqUVeJdDQv+fQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: fix return status of delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 8 Mar 2019 at 22:14, Bandan Das <bsd@redhat.com> wrote:
>
>
> Spotted by Coverity: CID 1399414
>
> mtp delete allows the a return status of delete succeeded,
> partial_delete or readonly - when none of the objects could be
> deleted.
>
> Some initiators recurse over the objects themselves. In that case,
> only READ_ONLY can be returned.
>
> Signed-off-by: Bandan Das <bsd@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 06e376bcd2..e3401aad75 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1137,9 +1137,9 @@ static MTPData *usb_mtp_get_object_prop_value(MTPState *s, MTPControl *c,
>
>  /* Return correct return code for a delete event */
>  enum {
> -    ALL_DELETE,
> -    PARTIAL_DELETE,
> +    ALL_DELETE = 1,
>      READ_ONLY,
> +    PARTIAL_DELETE,

This is an enum, ie a set of incrementing values, but you're
using them as bit positions you're ORing together. If they're
really bit flags you should define them properly that way,
so it's clear what you're doing.

At the moment PARTIAL_DELETE is "ALL_DELETE | READ_ONLY", which
doesn't seem like it makes much sense.

thanks
-- PMM
