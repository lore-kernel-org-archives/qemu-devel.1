Received: from eggs.gnu.org ([209.51.188.92]:47531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guZxP-0005bl-OK
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guZlg-0002Is-Ds
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:26:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guZlg-0002F2-86
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:26:48 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190214152251.2073-1-armbru@redhat.com>
	<87h8d65r6k.fsf@dusky.pond.sub.org>
	<e51e4eac-419b-bea0-6eef-8805ca45ebd6@redhat.com>
	<875ztlzdw8.fsf_-_@dusky.pond.sub.org>
	<ba0a9a4c-8ed4-7d4b-d5ac-77d60d04e38a@redhat.com>
Date: Fri, 15 Feb 2019 10:26:41 +0100
In-Reply-To: <ba0a9a4c-8ed4-7d4b-d5ac-77d60d04e38a@redhat.com> (Paolo
	Bonzini's message of "Fri, 15 Feb 2019 09:29:33 +0100")
Message-ID: <8736opxuzy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Proper use of unnest-vars
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>, marcandre.lureau@redhat.com, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 15/02/19 08:53, Markus Armbruster wrote:
>> This time, $(obj-y) is very much not blank, and...
>> 
>>     @qapi/ final qapi-introspect.o qapi-types-target.o qapi-types.o qapi-visit-target.o qapi-visit.o qapi-events-target.o qapi-events.o qapi-commands-target.o qapi-commands.o
>>     [Trailing make output elided]
>> 
>> ... qapi/Makefile.obj-y *does* clobber it.  Oww.
>> 
>> How come this works anyway?
>
> It works because at this point obj-y is not used anymore, it is assigned
> to all-obj-y a couple lines before:
>
> 	all-obj-y := $(obj-y)

Confirms my findings.

> As an aside, target-obj-y seems unnecessary to me.

I have no idea :)

$ git-grep target-obj-y
Makefile.objs:target-obj-y += trace/
Makefile.target:target-obj-y :=
Makefile.target:dummy := $(call unnest-vars,,target-obj-y)
Makefile.target:target-obj-y-save := $(target-obj-y)
Makefile.target:target-obj-y := $(target-obj-y-save)
Makefile.target:all-obj-y += $(target-obj-y)
trace/Makefile.objs:target-obj-y += generated-helpers.o
trace/Makefile.objs:target-obj-y += control-target.o

>> Perhaps unnest-vars could be more hygienic.
>
> Macro hygiene and Make in the same sentence? (well, not sentence but
> still...).

You're right.  My "perhaps could" should be read like "Perhaps we could
make pigs fly, if we apply enough force, say with a trebuchet".

>> But that's not my immediate
>> concern.  All I want to know right now is whether I should refrain from
>> = and := in Makefile.objs.  Paolo, Fam?
>
> No, there is no need for that.

Thanks!

> Really the answer is that we are kind of pushing Makefiles to the limit
> here.  We do get good expressiveness, but at the cost of hiding things
> behind black magic.  In the end I think it's a net benefit, but the cost
> does exist.

Concur.

It's actually not bad most of the time.  Once in a great while, I need
to do something more fancy, and then I'm prone to waste a few hours on
(re-)learning how to work with the magic.
