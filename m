Received: from eggs.gnu.org ([209.51.188.92]:34387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guZ3X-0000Hk-K3
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guYsL-0007Lo-0m
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:29:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1guYsK-0007J1-Pk
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:29:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so9026689wml.2
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 00:29:36 -0800 (PST)
References: <20190214152251.2073-1-armbru@redhat.com>
	<87h8d65r6k.fsf@dusky.pond.sub.org>
	<e51e4eac-419b-bea0-6eef-8805ca45ebd6@redhat.com>
	<875ztlzdw8.fsf_-_@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ba0a9a4c-8ed4-7d4b-d5ac-77d60d04e38a@redhat.com>
Date: Fri, 15 Feb 2019 09:29:33 +0100
MIME-Version: 1.0
In-Reply-To: <875ztlzdw8.fsf_-_@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Proper use of unnest-vars (was: [PATCH v5 00/18]
 qapi: add #if pre-processor conditions to generated code (part 3))
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, marcandre.lureau@redhat.com, qemu-devel@nongnu.org

On 15/02/19 08:53, Markus Armbruster wrote:
> This time, $(obj-y) is very much not blank, and...
> 
>     @qapi/ final qapi-introspect.o qapi-types-target.o qapi-types.o qapi-visit-target.o qapi-visit.o qapi-events-target.o qapi-events.o qapi-commands-target.o qapi-commands.o
>     [Trailing make output elided]
> 
> ... qapi/Makefile.obj-y *does* clobber it.  Oww.
> 
> How come this works anyway?

It works because at this point obj-y is not used anymore, it is assigned
to all-obj-y a couple lines before:

	all-obj-y := $(obj-y)

As an aside, target-obj-y seems unnecessary to me.

> Perhaps unnest-vars could be more hygienic.

Macro hygiene and Make in the same sentence? (well, not sentence but
still...).

> But that's not my immediate
> concern.  All I want to know right now is whether I should refrain from
> = and := in Makefile.objs.  Paolo, Fam?

No, there is no need for that.

Really the answer is that we are kind of pushing Makefiles to the limit
here.  We do get good expressiveness, but at the cost of hiding things
behind black magic.  In the end I think it's a net benefit, but the cost
does exist.

Paolo
