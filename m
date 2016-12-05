Received: from eggs.gnu.org ([2001:4830:134:3::10]:43890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cDxlp-0003cS-8F
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cDxll-00072X-Vf
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:13:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cDxll-00072R-Me
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:13:41 -0500
References: <1480713496-11213-1-git-send-email-ehabkost@redhat.com>
	<d611cf93-06e4-edc1-8012-1501f3b883ad@redhat.com>
	<20161205171135.GG13060@thinpad.lan.raisama.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2443f74f-ded5-a0e8-38e7-cff9fbab7688@redhat.com>
Date: Mon, 5 Dec 2016 19:13:36 +0100
MIME-Version: 1.0
In-Reply-To: <20161205171135.GG13060@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 00/17] target-i386: Implement
 query-cpu-model-expansion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>


>> Is static really needed? I can understand why migration-safe might be
>> of interest, but can't see how "static" could help (I mean we have
>> static expansion for this purpose). Do you have anything special in
>> mind regarding exposing "static"?
>
> I didn't have any specific use case in mind. My main worry is to
> avoid letting management software make any assumptions about the
> returned data. If we don't add an explicit "static" field, a
> client might make some wrong assumptions just because some
> conditions are known to be always true on existing
> implementations. e.g.: a client could incorrectly assume that
> "query-cpu-model-expansion type=full" of a migration-safe model
> would always be static.

I think "migration-safe" makes sense, as the doc currently states for
"@full": "The produced model is not guaranteed to be migration-safe".

For static expansion, this information is somewhat superfluous, as
"static CPU models are migration-safe", but it doesn't hurt. (and this
is also what you properly documented :) )

But I don't think that "static" will be of any use. If you want a
static model, go for "static" expansion. (I don't really see any use
case here, but if you do, keep it)


>> Something like that would be cool. Unfortunately, e.g. on s390x some
>> CPUID-like data (e.g. STFL(E) and SCP info) is only available from
>> kernel space. So we can't simply run a user space script. However,
>> something like a kernel module would be possible (or even something like the
>> s390x pc-bios to simply read and dump the data).
>
> I meant a kernel binary, above. On x86, there are existing test
> cases on the autotest repository that run a very small kernel[1]
> that simply dumps CPUID data to the serial console. We could
> reuse it, or we could add a CPUID command to the qtest protocol.
> I'm not sure what's the best solution.
>
> We can try to use a similar approach on s390x to reuse code in
> the test script, but we can add arch-specific code to it if
> necessary.

Ah, alright, so I wasn't aware of that because there is no autotest for
s390x (at least not that I know of ;) ). Thanks for the hint.

>
> [1] https://github.com/autotest/tp-qemu/tree/master/qemu/deps/cpuid/src
>


-- 

David
