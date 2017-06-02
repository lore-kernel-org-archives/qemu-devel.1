Received: from eggs.gnu.org ([2001:4830:134:3::10]:41115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGmn7-0005d0-TG
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGmn3-0007Jn-0p
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:39:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dGmn2-0007If-Rf
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:38:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C426E334584
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 13:38:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-18-marcandre.lureau@redhat.com>
Date: Fri, 02 Jun 2017 15:38:51 +0200
In-Reply-To: <20170531135709.345-18-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 31 May 2017 17:56:41 +0400")
Message-ID: <877f0ucxw4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 17/45] object: use more specific
 property type names
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

> Use the actual unsigned integer type name (this should't break since
> property type aren't directly accessed from outside it seems).

I checked.  Uses of Object member @type outside qom/object.c:

* vl.c's machine_help_func() puts it in help for -machine NAME,help.
  Fine.

* QMP command qom-list exposes it in ObjectPropertyInfo member @type.
  Your commit message is wrong :)

* QMP command device-list-properties exposes it in DevicePropertyInfo
  member @type.

* spapr_drc_populate_dt() compares it to "link<", which may or may not
  be a good idea, but isn't affected by your patch.

Uses in qom/object.c:

* object_property_is_child() compares it to "child<".  Not affected by
  your patch.

* object_property_get_enum() takes it as argument.  Shouldn't be
  affected by your patch, as only enumeration type names should occur
  here.  Double-checking: I can see "HostMemPolicy", "DummyAnimal",
  "BadAnimal" (the latter two in tests/, don't worry).  Okay.

* object_property_get_type() returns it.

  - qdev_print_props() only checks whether it succeeds.  Not affected by
    your patch.

  - object_resolve_link() requires it to be of the form "link<%s>".  Not
    affected by your patch unless we violate this precondition (and then
    we have worse problems).

* object_property_add_alias() copies it, possibly rewriting "child<%s>"
  to "link<%s>".  Shouldn't be affected by your patch.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Rewrite the commit message to explain impact on -machine, qom-list and
device-list-properties, and you may add

Reviewed-by: Markus Armbruster <armbru@redhat.com>
