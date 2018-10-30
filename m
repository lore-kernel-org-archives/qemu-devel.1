Received: from eggs.gnu.org ([2001:4830:134:3::10]:55941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHT3v-0005Co-Ht
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHT3q-0007oP-HL
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:23:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHT3q-0007ng-9d
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:23:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id r10-v6so12367851wrv.6
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 05:23:54 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-5-cota@braap.org>
	<87zhuw90eu.fsf@linaro.org> <20181029213927.GA19216@flamenco>
	<bae4de31-20da-c2c9-a3cf-e8e0b06a9a63@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <bae4de31-20da-c2c9-a3cf-e8e0b06a9a63@redhat.com>
Date: Tue, 30 Oct 2018 12:23:51 +0000
Message-ID: <87tvl38vxk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 05/71] cpu: move run_on_cpu to cpus-common
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/10/2018 22:39, Emilio G. Cota wrote:
>> I'm not convinced about adding an "assert(!user-mode)" to run_on_cpu.
>> Given that now it does not depend on the BQL, it could actually
>> work in user-mode if called. If we really wanted to make sure
>> that no user-mode would call it, then a compile-time check
>> would be better than an assert. But again, I fail to see what
>> we'd gain from that.
>>
>> For context, do_run_on_cpu et al. were moved to cpus-common.c by
>> d148d90ee8 ("cpus-common: move CPU work item management to
>> common code", 2016-09-27). The point was to consolidate the
>> run-on-cpu code in a common (softmmu & user-mode) file, since
>> user-mode needed async_run_on_cpu for exclusive work.
>>
>> Now we can finally make run_on_cpu generic as well.
>
> I agree, the run_on_cpu stuff should not be system-specific at all.

I'm happy to for it to be generic - just not broken ;-)

I'm not sure what sort of use cases it has at the moment given we use
start/end_exclusive for both atomics and system call marshalling in
linux-user. However have a common toolbox across system and linux-user
is a good thing.

>
> Paolo


--
Alex Benn=C3=A9e
