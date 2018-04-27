Received: from eggs.gnu.org ([2001:4830:134:3::10]:51285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC33s-0003k1-Ln
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC33r-0007aS-JZ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:05:16 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC33r-0007aL-F0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:05:15 -0400
Received: by mail-oi0-x244.google.com with SMTP id f63-v6so1503229oic.4
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:05:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1520945798-50640-13-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
	<1520945798-50640-13-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 14:04:54 +0100
Message-ID: <CAFEAcA9v3gOnXw1gVJg7vXC66FYbK2L9oxSuhvo6ZsnMST2+MA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 12/22] sev/i386: add command to create
 launch memory encryption context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Brijesh Singh <brijesh.singh@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 13 March 2018 at 12:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> From: Brijesh Singh <brijesh.singh@amd.com>
>
> The KVM_SEV_LAUNCH_START command creates a new VM encryption key (VEK).
> The encryption key created with the command will be used for encrypting
> the bootstrap images (such as guest bios).

Hi. Coverity points out a resource leak here (CID1390626):

> +static int
> +sev_launch_start(SEVState *s)
> +{
> +    gsize sz;
> +    int ret = 1;
> +    int fw_error;
> +    QSevGuestInfo *sev = s->sev_info;
> +    struct kvm_sev_launch_start *start;
> +    guchar *session = NULL, *dh_cert = NULL;
> +
> +    start = g_new0(struct kvm_sev_launch_start, 1);

Here we allocate memory into start...

> +
> +    start->handle = object_property_get_int(OBJECT(sev), "handle",
> +                                            &error_abort);
> +    start->policy = object_property_get_int(OBJECT(sev), "policy",
> +                                            &error_abort);
> +    if (sev->session_file) {
> +        if (sev_read_file_base64(sev->session_file, &session, &sz) < 0) {

...but here we exit without freeing it...

> +            return 1;
> +        }
> +        start->session_uaddr = (unsigned long)session;
> +        start->session_len = sz;
> +    }
> +
> +    if (sev->dh_cert_file) {
> +        if (sev_read_file_base64(sev->dh_cert_file, &dh_cert, &sz) < 0) {
> +            return 1;

...ditto here...

> +        }
> +        start->dh_uaddr = (unsigned long)dh_cert;
> +        start->dh_len = sz;
> +    }
> +
> +    trace_kvm_sev_launch_start(start->policy, session, dh_cert);
> +    ret = sev_ioctl(s->sev_fd, KVM_SEV_LAUNCH_START, start, &fw_error);
> +    if (ret < 0) {
> +        error_report("%s: LAUNCH_START ret=%d fw_error=%d '%s'",
> +                __func__, ret, fw_error, fw_error_to_str(fw_error));
> +        return 1;

...and here.

> +    }
> +
> +    object_property_set_int(OBJECT(sev), start->handle, "handle",
> +                            &error_abort);
> +    sev_set_guest_state(SEV_STATE_LAUNCH_UPDATE);
> +    s->handle = start->handle;
> +    s->policy = start->policy;
> +
> +    g_free(start);
> +    g_free(session);
> +    g_free(dh_cert);
> +
> +    return 0;
> +}

Coverity doesn't spot it, but I think we will also leak
the memory pointed to by session and dh_cert in some of those
error-exit paths.

thanks
-- PMM
