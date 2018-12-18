Received: from eggs.gnu.org ([2001:4830:134:3::10]:42478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZJxp-0001UF-FC
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZJxn-0001Xf-BC
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:19:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZJxl-0001KI-7B
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:19:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A452C0495B4
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 18:19:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181216140902.23986-1-marcandre.lureau@redhat.com>
Date: Tue, 18 Dec 2018 19:19:16 +0100
In-Reply-To: <20181216140902.23986-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Sun, 16 Dec 2018 18:08:49 +0400")
Message-ID: <87lg4mbsuz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/13] qapi: add #if pre-processor
 conditions to generated code (part 3)
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

> Hi,
>
> The thrid and last part (of "[PATCH v2 00/54] qapi: add #if
> pre-processor conditions to generated code") is about adding schema
> conditions based on the target.
>
> For now, the qapi code is compiled in common objects (common to all
> targets). This makes it impossible to add #if TARGET_ARM for example.
>
> The patch "RFC: qapi: learn to split the schema by 'top-unit'"
> proposes to split the schema by "top-unit", so that generated code can
> be built either in common objects or per-target. That patch is a bit
> rough, I would like to get some feedback about the approach before
> trying to improve it. The following patches demonstrate usage of
> target-based #if conditions, and getting rid of the
> qmp_unregister_command() hack.

Lovely except for the 'top-unit' feature.  I believe the existing
modules can do the job.  Quoting my "[PATCH v2 00/29] Modularize
generated QAPI code":

    Related: Marc-Andr=C3=A9's 'unit' pragma proposal.  That's a different
    way to split off parts of the generated code, motivated by the
    desire to use poisoned identifiers such as TARGET_I386.  I noted in
    my review of v3 that I "can either accept it, or come up with a
    better solution."  This is my attempt at a better solution.  It's a
    bit more ambitious, and thus more useful (I hope).  The pragma has
    one theoretical advantage, though: you can modularize the generated
    output in different ways than the input.  The patches using don't do
    that, however.

I'm going to post RFC patches that show how to do a target-dependent
module.  Then we can discuss the two approaches.
