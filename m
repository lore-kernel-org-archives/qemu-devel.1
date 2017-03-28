Received: from eggs.gnu.org ([2001:4830:134:3::10]:43080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csqRq-000813-Pn
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csqRl-0006Xq-Qi
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:42:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csqRl-0006Wl-Ka
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:42:01 -0400
References: <1490653177-131484-1-git-send-email-agraf@suse.de>
	<20170328004108.GP28530@thinpad.lan.raisama.net>
	<9d85e056-3331-9815-404b-9557ca5028cc@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <39d88a40-727b-81e9-0577-27198457304e@redhat.com>
Date: Tue, 28 Mar 2017 14:41:55 +0200
MIME-Version: 1.0
In-Reply-To: <9d85e056-3331-9815-404b-9557ca5028cc@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: Allow cpuid bit override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>



On 28/03/2017 13:26, Alexander Graf wrote:
>> You can define an enum type in qapi-schema.json, and use
>> visit_type_<YourEnumType>(). You can grep for
>> visit_type_OnOffAuto to find examples.
>>
>> (But I suggest naming the enum something like
>> "X86CPUFeatureSetting" instead of "OnOffForce", because we will
>> probably add other enum values in the future).
>>
>> However: we need to find a way to do this and not break
>> compatibility with "feat=yes|true|no|false", that's supported by
>> StringInputVisitor (which is used by object_property_parse()).
>> Maybe fallback to visit_type_bool() in case
>> visit_type_<YourEnumType>() fails?
> 
> Putting it into a special enum sounds much more fragile than the current
> solution to me. We need to bool fallback either way, so I fail to see
> any benefit from having the enum.

Using an on/off/force enum sounds like the right thing to do.

However, I would open code the getters and setters completely (using
visit_type_str) instead of using visit_type_FooEnum+visit_type_bool.
Then you can easily map yes/true to on and no/false to off.

Paolo
