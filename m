Received: from eggs.gnu.org ([2001:4830:134:3::10]:45968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fovgz-0001tb-Sj
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 15:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fovgv-0008Mz-Qa
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 15:06:21 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:45206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fovgv-0008Mu-IM
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 15:06:17 -0400
Received: by mail-wr1-f42.google.com with SMTP id f12-v6so12406072wrv.12
	for <qemu-devel@nongnu.org>; Sun, 12 Aug 2018 12:06:17 -0700 (PDT)
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-29-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34547af9-dc93-687f-5a23-901fa8ebfaef@redhat.com>
Date: Sun, 12 Aug 2018 11:52:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-29-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 28/56] json: Fix \uXXXX for surrogate pairs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/08/2018 14:03, Markus Armbruster wrote:
> +                if (cp >= 0xD800 && cp <= 0xDBFF && !leading_surrogate
> +                    && ptr[1] == '\\' && ptr[2] == 'u') {
> +                    ptr += 2;
> +                    leading_surrogate = cp;
> +                    goto hex;
> +                }
> +                if (cp >= 0xDC00 && cp <= 0xDFFF && leading_surrogate) {
> +                    cp &= 0x3FF;
> +                    cp |= (leading_surrogate & 0x3FF) << 10;
> +                    cp += 0x010000;
> +                }
> +

The leading surrogate is discarded for \uD800\uCAFE, I think.  Is this
desired?

Paolo
