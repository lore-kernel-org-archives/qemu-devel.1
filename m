Received: from eggs.gnu.org ([2001:4830:134:3::10]:48082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQvFT-0004oa-1E
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:14:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQvFC-0004jn-Nx
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:14:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eQvFC-0004i9-DP
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:14:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9664580082
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:14:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
Date: Mon, 18 Dec 2017 14:14:01 +0100
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 11 Sep 2017 13:05:33 +0200")
Message-ID: <87r2rsfaau.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/50] Hi,
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

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
>
> Starting from patch "qapi: add conditions to VNC type/commands/events
> on the schema", the series demonstrate adding conditions, in order to
> remove qmp_unregister_commands_hack(). The main difference with v2, is
> the addition of a per-target schema in "build-sys: add a target
> schema". This removes the NEED_CPU_H hack, and keep most of the qapi
> files in common build.
>
> There are a lot more things we could make conditional in the QAPI
> schema, like pci/kvm/xen/numa/vde/slirp/posix/win32/vsock/lzo etc etc,
> however I am still evaluating the implication of such changes both
> externally and internally, for those interested, I can share my wip
> branch.
>
> Comments welcome,
>
> v3:
> - rebased (qlit is now merged upstream)
> - solve the per-target #ifdef problem by using a target.json
>   and new qapi generated target files
> - update some commit messages based on Markus review
> - more schema error reporting
> - move the ifcond argument closer to info/doc
> - use mcgen() in gen_if()/gen_endif()
> - simplify "modify to_qlit() to take an optional suffix"
> - fix generated qlit indentation
> - fix temporary build break by merging #if types & visitors patch
> - fix some redundant condtionals generation
> - change enum visitor to take QAPISchemaMember
> - reject unknown dictionnary keys in { .., 'if': ..}
> - split qapi test visitor print() with trailing ',' trick

Things I like:

* How you add conditionals to the QAPI language

* How the generated code changes

Things I don't like so much:

* A few commit messages are just too terse

* Code and its test added in separate patches

* ifcond_decorator

  I guess can either accept it, or come up with a better solution.

* Unconventional handling of sugared forms (see my review of PATCH 28).

* Addressing complilation consistency problems (see my review of PATCH
  17) before addressing them by splitting off target-specific generated
  files (PATCH 39..)

* Manual splitting of the generated monolith with pragma unit, -i and
  -u.  I guess can either accept it, or come up with a better solution.

Additionally, there are couple of minor things here and there, and a few
questions.  The usual patch review business.

Overall, there's much more for me to like than to dislike :)
