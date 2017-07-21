Received: from eggs.gnu.org ([2001:4830:134:3::10]:47849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYLPN-0003gX-7i
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 20:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYLPK-0005I9-6Q
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 20:03:05 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:37971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dYLPK-0005Gk-1l
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 20:03:02 -0400
Received: by mail-qt0-x230.google.com with SMTP id o8so33001655qtc.5
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 17:03:00 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-36-git-send-email-cota@braap.org>
	<06200ec3-3c8b-4e69-a339-76b22b99e4d1@twiddle.net>
	<20170720235306.GA6330@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <13fdfcaa-2875-2c21-c749-d488a8b239c3@twiddle.net>
Date: Thu, 20 Jul 2017 14:02:53 -1000
MIME-Version: 1.0
In-Reply-To: <20170720235306.GA6330@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 35/43] tcg: dynamically allocate
 optimizer temps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 07/20/2017 01:53 PM, Emilio G. Cota wrote:
> BTW, is there any chance that the pool will be initialized before we copy
> tcg_init_ctx? That'd mean the main thread has performed translation, which
> seems unlikely to me. But should then we bother clearing the TCGProfile
> counters after we copy tcg_init_ctx? I don't see how without translation
> counters would be !0.

I wouldn't think so.  This cpu setup should be happening very early.

We could perhaps look at arranging fields such that all the fields that are 
"shared" between the contexts are up front, and use the qemu standard

   memcpy(new, old, offsetof(TCGContext, end_common_fields));

trick, and zero the rest.


r~
