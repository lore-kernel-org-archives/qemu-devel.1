Received: from eggs.gnu.org ([2001:4830:134:3::10]:54715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diLHK-00044K-P0
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diLHG-0002RP-3W
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:56:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1diLHF-0002QS-QF
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:56:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E6C990159
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 13:56:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
Date: Thu, 17 Aug 2017 15:55:51 +0200
In-Reply-To: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 27 Jul 2017 17:41:00 +0200")
Message-ID: <87efsab8ns.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/26] qapi: add #if pre-processor
 conditions to generated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi,
>
> In order to clean-up some hacks in qapi (having to unregister commands
> at runtime), I proposed a "[PATCH v5 02/20] qapi.py: add a simple #ifdef =
condition"
>
> (see http://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03106.html).
>
> However, we decided to drop that patch from the series and solve the
> problem later. The main issues were:
> - the syntax was awkward to the JSON schema and documentation
> - the evaluation of the condition was done in the qapi scripts, with
>   very limited capability
> - each target/config would need different generated files.
>
> Instead, it could defer the #if evaluation to the C-preprocessor.
>
> With this series, top-level qapi JSON entity can take 'if' keys:
>
> { 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
>   'if': 'defined(TEST_IF_STRUCT)' }
>
> Members can be exploded as dictionnary with 'type'/'if' keys:
>
> { 'struct': 'TestIfStruct', 'data':
>   { 'foo': 'int',
>     'bar': { 'type': 'int', 'if': 'defined(TEST_IF_STRUCT_BAR)'} } }
>
> Enum values can be exploded as dictionnary with 'type'/'if' keys:
>
> { 'enum': 'TestIfEnum', 'data':
>   [ 'foo',
>     { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ] }
>
> A good benefit from having conditional schema is that introspection
> will reflect more accurately the capability of the server. Another
> benefit is that it may help to remove some dead code when disabling a
> functionality.

This is the main benefit.  Until we realize it, introspection remains
seriously hobbled.

A few closing remarks.

The general approach "generate the #if for the compiler to evaluate"
looks sound.

I haven't been able to fully review how it's integrated into the QAPI
language and how the generators implement it.  I hope a bit of judicious
patch splitting will help me over the hump.

As so often, solving one problem makes other problems more visible.  In
this case, the problem that we generate a monolith, and pay for that
with compile time.  More of it once we compile the monolith per target.

> Starting from patch "qapi: add conditions to VNC type/commands/events
> on the schema", the series demonstrate adding conditions, in order to
> remove qmp_unregister_commands_hack(). However, it feels like I
> cheated a little bit by using per-target NEED_CPU_H in the headers to
> avoid #define poison. The alternative could be to split the headers in
> common/target?

Yup, we could really use a way to modularize the generated code.

If your work leads us to ideas on how to crack the monolith, great.  If
not, we'll have to decide whether we can live with the compile time hit.
I'd rather not block your work on cracking the monolith.

> There are a lot more things we could make conditional in the QAPI
> schema, like pci/kvm/xen/numa/vde/slirp/posix/win32/vsock/lzo etc etc,
> however I am still evaluating the implication of such changes both
> externally and internally, for those interested, I can share my wip
> branch.

You provide the infrastructure and useful examples of use.  Good enough,
no need to hunt down *all* uses right away.
