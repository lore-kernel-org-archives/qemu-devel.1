Received: from eggs.gnu.org ([2001:4830:134:3::10]:48959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2tI-00072o-E3
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2tH-0000zH-Cw
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:54:20 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:44551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC2tH-0000z7-8L
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:54:19 -0400
Received: by mail-oi0-x235.google.com with SMTP id e80-v6so1455757oig.11
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 05:54:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1520945798-50640-23-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
	<1520945798-50640-23-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 13:53:57 +0100
Message-ID: <CAFEAcA_Gne1c4+D75BBNuHMV8UQaqbzpJC+z6qkcYApH7iGUrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 22/22] sev/i386: add sev_get_capabilities()
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
> The function can be used to get the current SEV capabilities.
> The capabilities include platform diffie-hellman key (pdh) and certificate
> chain. The key can be provided to the external entities which wants to
> establish a trusted channel between SEV firmware and guest owner.

Hi; Coverity points out a resource leak in this function.

> +SevCapability *
> +sev_get_capabilities(void)
> +{
> +    SevCapability *cap;
> +    guchar *pdh_data, *cert_chain_data;
> +    size_t pdh_len = 0, cert_chain_len = 0;
> +    uint32_t ebx;
> +    int fd;
> +
> +    fd = open(DEFAULT_SEV_DEVICE, O_RDWR);
> +    if (fd < 0) {
> +        error_report("%s: Failed to open %s '%s'", __func__,
> +                     DEFAULT_SEV_DEVICE, strerror(errno));
> +        return NULL;
> +    }
> +
> +    if (sev_get_pdh_info(fd, &pdh_data, &pdh_len,
> +                         &cert_chain_data, &cert_chain_len)) {
> +        return NULL;

CID 1390570 says that in this error-return path we leak
fd(), because we never close it.

> +    }
> +
> +    cap = g_new0(SevCapability, 1);
> +    cap->pdh = g_base64_encode(pdh_data, pdh_len);
> +    cap->cert_chain = g_base64_encode(cert_chain_data, cert_chain_len);
> +
> +    host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
> +    cap->cbitpos = ebx & 0x3f;
> +
> +    /*
> +     * When SEV feature is enabled, we loose one bit in guest physical
> +     * addressing.
> +     */
> +    cap->reduced_phys_bits = 1;
> +
> +    g_free(pdh_data);
> +    g_free(cert_chain_data);
> +
> +    close(fd);
> +    return cap;
> +}

thanks
-- PMM
