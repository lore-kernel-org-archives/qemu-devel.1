Received: from eggs.gnu.org ([2001:4830:134:3::10]:56342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ePsGA-0005pA-Vr
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ePsG7-0000GM-2l
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:50:51 -0500
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d]:39151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ePsG6-0000EH-TH
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:50:47 -0500
Received: by mail-it0-x22d.google.com with SMTP id 68so19931758ite.4
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 07:50:46 -0800 (PST)
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<32f8bbf4-1fb6-b974-f7ca-f5a91adf875e@redhat.com>
	<CAFEAcA8j_tGZr-i5LE+ZXAnk4v=pfrKadmgsf=ncMHRUsYK1zQ@mail.gmail.com>
	<b5a01fb0-4f25-7cae-99d3-c9722912b6c1@redhat.com>
	<cfe0f5b0-39e7-6bd1-3caf-4abb855275ec@redhat.com>
	<0895424e-ad82-be08-4232-0f46369a946b@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <59ab84cc-ec75-b55b-a6db-519dc4589727@linaro.org>
Date: Fri, 15 Dec 2017 09:50:41 -0600
MIME-Version: 1.0
In-Reply-To: <0895424e-ad82-be08-4232-0f46369a946b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] Scoped locks using
 attribute((cleanup))
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 12/12/2017 02:41 PM, Eric Blake wrote:
> On 12/11/2017 03:32 PM, Paolo Bonzini wrote:
>> On 11/12/2017 15:11, Eric Blake wrote:
>>> I don't know if there is a way to make gcc insert stack-unwind
>>> directives that are honored across longjmp (I know C++ does it for
>>> exceptions; so there may be a way, and I just don't know it).
>>
>> Probably -fexceptions.
>>
> 
> Well, that's what 'info gcc' mentions:
> 
> 'cleanup (CLEANUP_FUNCTION)'
>      The 'cleanup' attribute runs a function when the variable goes out
>      of scope.  This attribute can only be applied to auto function
>      scope variables; it may not be applied to parameters or variables
>      with static storage duration.  The function must take one
>      parameter, a pointer to a type compatible with the variable.  The
>      return value of the function (if any) is ignored.
> 
>      If '-fexceptions' is enabled, then CLEANUP_FUNCTION is run during
>      the stack unwinding that happens during the processing of the
>      exception.  Note that the 'cleanup' attribute does not allow the
>      exception to be caught, only to perform an action.  It is undefined
>      what happens if CLEANUP_FUNCTION does not return normally.
> 
> but adding -fexceptions to my sample program does NOT make a difference
> (apparently, unwind cleanup triggered by C++ exceptions is NOT the same
> as unwinding done by longjmp()).

longjmp isn't an exception, and so doesn't run stack cleanups.  You'd need to
use _Unwind_Throw ... except for the fact that C doesn't have a mechanism by
which we can catch it.

We would really need to use C++ and throw to get those semantics.


r~
