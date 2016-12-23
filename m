Received: from eggs.gnu.org ([2001:4830:134:3::10]:58060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cKMSx-000725-PP
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 04:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cKMSt-0002J2-LP
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 04:48:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cKMSt-0002Im-Cx
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 04:48:39 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B05A6C05AA52
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 09:48:37 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
Date: Fri, 23 Dec 2016 10:48:35 +0100
In-Reply-To: <20161206141343.28044-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 6 Dec 2016 17:13:26 +0300")
Message-ID: <87fulfkmbw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/17] qapi doc generation (whole
 version, squashed)
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

> Add a qapi2texi script to generate the documentation from the qapi
> schemas.
>
> The SQUASHED patch in this series is a squashed version of the
> documentation move from qmp-commands.txt to the schemas. The whole
> version (not sent on the ML to avoid spamming) is in the following git
> branch: https://github.com/elmarco/qemu/commits/qapi-doc
>
> PDF preview:
> https://fedorapeople.org/~elmarco/qemu-qmp-ref.pdf
>
> v6:
> - rebased on top of armbru/qapi-next branch
> - add a few patches to improve Exception subclasses and usage in
>   qapi.py as suggested during review
> - parser and generator fixes and improvements after v5 review:
>   - various union improvements, hopefully with a better syntax
>   - improve error messages
>   - improve docs/qapi-code-gen.txt documentation section
>   - do not allow interleaved body documentation between sections
>   - more tests for new cases
>   - make expression documentation mandatory, fix the tests
>   - replace bad usage of @var{} with @t{} in texi, fix texi2pod to
>     handle it
>   - renaming, reordering etc..
> - add docs/qapi-syntax.texi to describe the API syntax used in the
>   texi documentation
> - fix interleaved body and section documentation
> - improve documentation sections name
> - many build-sys improvements after review
> - fix and improve commit messages, update R-b tags

There's quite some new material in v6.  How can we converge on something
mergable quickly?  Let me review my review.

PATCH 01-04,06,12-16 are ready with minor tweaks here and there.

PATCH 17 "build-sys: add qapi doc generation targets" is almost ready:
one a simple question left.

PATCH 07 should be dropped.  The idea it implements is mine, but it's a
bad one %-)

PATCH 09 "texi2pod: learn quotation, deftp and deftypefn" still needs
review, but is probably just fine, so let's not worry about it.

PATCH 10 "json: reorder documentation body" looks problematic.  Can we
postpone it?

PATCH 11 "(SQUASHED) move doc to schema" could use double-checking, but
only when we're ready to commit it.  Let's not worry about it.

PATCH 05 "docs: add master qapi texi files" has major documentation
improvements since v5, which are not ready.  Besides issues with the
documentation, there are issues with what's being documented.  To
converge on this one, we also need to converge on PATCH 08.

PATCH 08 "qapi: add qapi2texi script" is the core of the matter.  I
proposed a bunch of FIXME comments, minor tweaks and fixes.  A few more
issues are still open, but we should be able to address them with only
minor churn.

There's one feature that I feel takes us in the wrong direction: the
invention of a formal language to describe QAPI definitions from the
user's point of view.  I doubt this language is necessary.  Both the
language and its documentation in PATCH 05 have numerous issues, and
this is a major reason for PATCH 05 not being ready.

I'm proposing to rip out this part for now, along with all of the new
documentation (revert to PATCH 05 v5).  Not ideal, because the series
then regresses QMP documentation (JSON type information lost), and
leaves the new, doc comment requirements and features undocumented.  So
add suitable FIXMEs, and make updating the documentation a priority.
Once that's done, we can discuss how to add back type information, and
what to do about the proposed formal language.

Does this sound like a sensible plan?
