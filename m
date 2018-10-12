Received: from eggs.gnu.org ([2001:4830:134:3::10]:42966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gB1RY-0001SU-B3
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gB1RV-0000V6-4W
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:41:44 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:35520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gB1RU-0000Qd-Id
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:41:40 -0400
Received: by mail-pf1-x429.google.com with SMTP id l17-v6so6553436pff.2
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 10:41:37 -0700 (PDT)
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-2-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <364642df-1e17-dbea-1cec-a5cf6c606b27@linaro.org>
Date: Fri, 12 Oct 2018 10:41:33 -0700
MIME-Version: 1.0
In-Reply-To: <20181012032431.32693-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/5] virtio-balloon: Remove unnecessary
 MADV_WILLNEED on deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com
Cc: pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com

On 10/11/18 8:24 PM, David Gibson wrote:
> When the balloon is inflated, we discard memory place in it using madvise()
> with MADV_DONTNEED.  And when we deflate it we use MADV_WILLNEED, which
> sounds like it makes sense but is actually unnecessary.
> 
> The misleadingly named MADV_DONTNEED just discards the memory in question,
> it doesn't set any persistent state on it in-kernel; all that's necessary
> to bring the memory back is to touch it.


Isn't the point of deflate to free up host memory, for use by other guests or
whatever?

If you do nothing upon deflate, then that doesn't actually happen.  It seems to
me that this is backward and you should use DONTNEED on deflate and then
inflate should do nothing.


r~
