Received: from eggs.gnu.org ([209.51.188.92]:45793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1CiP-0002CN-5V
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1CiO-0006Fz-Bp
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:14:49 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:41030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1CiO-0006FK-3A
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:14:48 -0500
Received: by mail-ot1-x334.google.com with SMTP id t7so7879459otk.8
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:14:47 -0800 (PST)
MIME-Version: 1.0
References: <20180227083919.12339-1-kraxel@redhat.com>
	<20180227083919.12339-4-kraxel@redhat.com>
In-Reply-To: <20180227083919.12339-4-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2019 16:14:34 +0000
Message-ID: <CAFEAcA_5QvBdozaJLNe2mBPu3HhkTyt_oP2jXZ30hHjZDtmn6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 3/5] usb-mtp: Support delete of mtp objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bandan Das <bsd@redhat.com>

On Tue, 27 Feb 2018 at 08:41, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> From: Bandan Das <bsd@redhat.com>
>
> Write of existing objects by the initiator is acheived by
> making a temporary buffer with the new changes, deleting the
> old file and then writing a new file with the same name.
>
> Also, add a "readonly" property which needs to be set to false
> for deletion to work.

Hi -- Coverity points out a use-after-free here (CID 1399144):



> +static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
> +{
> +    MTPObject *iter, *iter2;
> +    bool partial_delete = false;
> +    bool success = false;
> +
> +    /*
> +     * TODO: Add support for Protection Status
> +     */
> +
> +    QLIST_FOREACH(iter, &o->children, list) {
> +        if (iter->format == FMT_ASSOCIATION) {
> +            QLIST_FOREACH(iter2, &iter->children, list) {
> +                usb_mtp_deletefn(s, iter2, trans);
> +            }
> +        }
> +    }
> +
> +    if (o->format == FMT_UNDEFINED_OBJECT) {
> +        if (remove(o->path)) {
> +            partial_delete = true;
> +        } else {
> +            usb_mtp_object_free_one(s, o);

This call will call g_free(o)...

> +            success = true;
> +        }
> +    }
> +
> +    if (o->format == FMT_ASSOCIATION) {

...but flow of control then falls through to here, where
we try to access o->format.

Preusumably this should be an "else if" clause ?
> +        if (rmdir(o->path)) {
> +            partial_delete = true;
> +        } else {
> +            usb_mtp_object_free_one(s, o);
> +            success = true;
> +        }
> +    }
> +
> +    if (success && partial_delete) {
> +        return PARTIAL_DELETE;
> +    }
> +    if (!success && partial_delete) {
> +        return READ_ONLY;
> +    }
> +    return ALL_DELETE;
> +}
> +

thanks
-- PMM
