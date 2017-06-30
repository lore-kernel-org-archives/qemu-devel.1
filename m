Received: from eggs.gnu.org ([2001:4830:134:3::10]:58279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQqgS-0007Eq-Ef
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQqgP-0005OS-Aq
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:49:44 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:33053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dQqgP-0005NS-4b
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:49:41 -0400
Received: by mail-qt0-x229.google.com with SMTP id r30so92773840qtc.0
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 00:49:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
	<1498768109-4092-4-git-send-email-cota@braap.org>
	<c0d720c9-e63e-1d5d-8b78-a1b66e179a20@twiddle.net>
Message-ID: <dfb7a099-6cd7-1f0d-9fad-047f670a32dc@twiddle.net>
Date: Fri, 30 Jun 2017 00:49:37 -0700
MIME-Version: 1.0
In-Reply-To: <c0d720c9-e63e-1d5d-8b78-a1b66e179a20@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/7] translate-all: use a binary search tree
 to track TBs in TBContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 06/30/2017 12:41 AM, Richard Henderson wrote:
> On 06/29/2017 01:28 PM, Emilio G. Cota wrote:
>> +/* @key is already in the tree so it's safe to use container_of on it */
>> +static gint tc_ptr_cmp(gconstpointer candidate, gconstpointer key)
>> +{
>> +    uintptr_t a = *(uintptr_t *)candidate;
>> +    const TranslationBlock *tb = container_of(key, TranslationBlock, tc_ptr);
> 
> This I'm not keen on.  It'd be one thing if it was our own datastructure, but I 
> see nothing in the GTree documentation that says that the comparison must 
> always be done this way.

What if we bundle tc_ptr + tc_size into a struct and only reference that?  We'd 
embed that struct into the TB.  In tb_find_pc, create that struct on the stack, 
setting tc_size = 0.


r~
