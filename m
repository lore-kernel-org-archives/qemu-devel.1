Received: from eggs.gnu.org ([2001:4830:134:3::10]:43964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d60KY-0004bV-7d
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d60KV-0007NT-4H
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:52:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d60KU-0007Ly-Rh
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:52:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v43JmxdW004183
	for <qemu-devel@nongnu.org>; Wed, 3 May 2017 15:52:52 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a7hbj4fc3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 15:52:52 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 3 May 2017 15:52:51 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <87a86u48sa.fsf@dusky.pond.sub.org>
References: <20170427215821.19397-1-eblake@redhat.com>
	<20170427215821.19397-11-eblake@redhat.com>
	<149374359665.32299.11589637295145834940@loki>
	<149374416427.32299.10266856249198036332@loki>
	<87a86u48sa.fsf@dusky.pond.sub.org>
Date: Wed, 03 May 2017 14:52:42 -0500
Message-Id: <149384116260.9473.5031989947486335691@loki>
Subject: Re: [Qemu-devel] [PATCH v5 10/10] test-qga: Actually test 0xff sync
 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

Quoting Markus Armbruster (2017-05-03 03:57:41)
> Michael Roth <mdroth@linux.vnet.ibm.com> writes:
> =

> > Quoting Michael Roth (2017-05-02 11:46:36)
> >> Quoting Eric Blake (2017-04-27 16:58:21)
> >> > Commit 62c39b3 introduced test-qga, and at face value, appears
> >> > to be testing the 'guest-sync' behavior that is recommended for
> >> > guests in sending 0xff to QGA to force the parser to reset.  But
> >> > this aspect of the test has never actually done anything: the
> >> > qmp_fd() call chain converts its string argument into QObject,
> >> > then converts that QObject back to the actual string that is
> >> > sent over the wire - and the conversion process silently drops
> >> > the 0xff byte from the string sent to QGA, thus never resetting
> >> > the QGA parser.
> >> > =

> >> > An upcoming patch will get rid of the wasteful round trip
> >> > through QObject, at which point the string in test-qga will be
> >> > directly sent over the wire.
> >> > =

> >> > But fixing qmp_fd() to actually send 0xff over the wire is not
> >> > all we have to do - the actual QMP parser loudly complains that
> >> > 0xff is not valid JSON, and sends an error message _prior_ to
> >> > actually parsing the 'guest-sync' or 'guest-sync-delimited'
> >> > command.  With 'guest-sync', we cannot easily tell if this error
> >> > message is a result of our command - which is WHY we invented
> >> > the 'guest-sync-delimited' command.  So for the testsuite, fix
> >> > things to only check 0xff behavior on 'guest-sync-delimited',
> >> > and to loop until we've consumed all garbage prior to the
> >> > requested delimiter, which matches the documented actions that
> >> > a real QGA client is supposed to do.
> >> =

> >> The full re-sync sequence is actually to perform that process,
> >> check if the response matches the client-provided sync token,
> >> and then repeat the procedure if it doesn't (in the odd case
> >> that a previous client initiated a guest-sync-delimited
> >> sequence and never consumed the response). The current
> >> implementation only performs one iteration so it's not quite
> >> a full implementation of the documentation procedure.
> >
> > Well, to be more accurate it's a full implementation of the
> > documented procedure, it's just that the procedure isn't
> > fully documented properly. I'll send a patch to address that.
> =

> Good.
> =

> >> For the immediate purpose of improving the handling to deal
> >> with the 0xFF-generated error the patch seems sound though,
> >> maybe just something worth noting in the commit msg or
> >> comments so that we might eventually test the full procedure.
> =

> Feel free to suggest something for me to add to the commit message.

Maybe change:

  "which matches the documented actions that a real QGA client
   is supposed to do."

to

  "which is compatible with the documented actions that a real
   QGA client is supposed to do."

and add the following comment to test_qga_sync_delimited

  /* =

   * Note that the full reset sequence would involve checking the
   * response of guest-sync-delimited and repeating the loop if
   * 'id' field of the response does not match the 'id' field of =

   * the request. Testing this fully would require inserting
   * garbage in the response stream and is left as a future test
   * to implement.
   */

> =

> >> In any case:
> >> =

> >> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> =

> Noted, thanks!
>=20
