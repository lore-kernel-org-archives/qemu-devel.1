Received: from eggs.gnu.org ([2001:4830:134:3::10]:33746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSKDH-0000pi-O5
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSKDG-0006S0-QX
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:33:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSKDG-0006Qg-KC
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:33:42 -0400
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-5-git-send-email-pbonzini@redhat.com>
	<1cfd6e25-727e-2b11-b662-4a2b7dbaed05@twiddle.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e0fdd72-2168-cda5-fe01-e8e5379e0b8c@redhat.com>
Date: Tue, 4 Jul 2017 11:33:38 +0200
MIME-Version: 1.0
In-Reply-To: <1cfd6e25-727e-2b11-b662-4a2b7dbaed05@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/22] vl: convert -tb-size to qemu_strtoul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com



On 03/07/2017 21:46, Richard Henderson wrote:
> On 07/03/2017 09:34 AM, Paolo Bonzini wrote:
>> -extern int tcg_tb_size;
>> +extern unsigned long tcg_tb_size;
> 
> size_t would be more natural.
> 
> I don't think we support any hosts for which sizeof(size_t) !=
> sizeof(unsigned long), but perhaps

There's Win64...  Another place where to do the range check
could be tcg_exec_init.  That's where the actual bug lies.

The previous code's error handling was even worse, since strtol's output
was completely unchecked.  tcg_exec_init can be fixed later.

Paolo

>     unsigned lomg tmp;
>     if (qemu_strtoul(optarg, NULL, 0, &tmp) < 0
>             || tmp != (size_t)tmp) {
>       error_report("Invalid argument to -tb-size");
>       exit(1);
>     }
>     tcg_tb_size = tmp;
> 
> where I'd expect the extra comparison to be optimized away.
> 
> But I'm not overly concerned either way, so
> 
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> 
> 
> r~
