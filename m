Received: from eggs.gnu.org ([2001:4830:134:3::10]:50727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC30X-0001kf-US
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC30U-0005pw-2h
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:01:50 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:38273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC30T-0005pg-UK
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:01:46 -0400
Received: by mail-ot0-x243.google.com with SMTP id j27-v6so1916855ota.5
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:01:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1520945798-50640-11-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
	<1520945798-50640-11-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 14:01:24 +0100
Message-ID: <CAFEAcA8AAJK+oMyhY9QGSR4-i0FT3QhHNGF+L_gMmYP6BeM8-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 10/22] sev/i386: add command to initialize
 the memory encryption context
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
> When memory encryption is enabled, KVM_SEV_INIT command is used to
> initialize the platform. The command loads the SEV related persistent
> data from non-volatile storage and initializes the platform context.
> This command should be first issued before invoking any other guest
> commands provided by the SEV firmware.

Hi; Coverity points out a memory leak in this code
(CID 1390613):

> +void *
> +sev_guest_init(const char *id)
> +{
> +    SEVState *s;
> +    char *devname;
> +    int ret, fw_error;
> +    uint32_t ebx;
> +    uint32_t host_cbitpos;
> +    struct sev_user_data_status status = {};
> +
> +    s = g_new0(SEVState, 1);

Here we allocate memory into 's'...

> +    s->sev_info = lookup_sev_guest_info(id);
> +    if (!s->sev_info) {
> +        error_report("%s: '%s' is not a valid '%s' object",
> +                     __func__, id, TYPE_QSEV_GUEST_INFO);
> +        goto err;

...and this error-exit path will not free it because
it does g_free(sev_state), not g_free(s).

> +    }
> +
> +    sev_state = s;
> +    s->state = SEV_STATE_UNINIT;

[...]

> +err:
> +    g_free(sev_state);
> +    sev_state = NULL;
> +    return NULL;
> +}

The simplest fix is probably to move the 'sev_state = s;
s->state = SEV_STATE_UNINIT;' assignments to earlier in the
function.

Cleaner might be to ensure that nothing in the rest of
the function depends on sev_state being initialized,
and then to work purely with 's' and only set sev_state
to s just before returning success.

thanks
-- PMM
