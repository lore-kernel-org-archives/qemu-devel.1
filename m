Received: from eggs.gnu.org ([2001:4830:134:3::10]:40645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXMor-00031i-TU
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 03:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXMoW-0002y3-Pw
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 03:57:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXMoU-0002uM-C5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 03:57:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 929D83002F2E
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 08:57:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181206121743.20762-1-armbru@redhat.com>
Date: Thu, 13 Dec 2018 09:57:40 +0100
In-Reply-To: <20181206121743.20762-1-armbru@redhat.com> (Markus Armbruster's
	message of "Thu, 6 Dec 2018 13:17:43 +0100")
Message-ID: <87ftv1by7v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] json: Fix to reject duplicate object
 member names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mreitz@redhat.com, eblake@redhat.com, berrange@redhat.com, dgilbert@redhat.com

Markus Armbruster <armbru@redhat.com> writes:

> The JSON parser happily accepts duplicate object member names.  The
> last value wins.  Reproducer #1:
>
>     $ qemu-system-x86_64 -qmp stdio
>     {"QMP": {"version": {"qemu": {"micro": 93, "minor": 0, "major": 3},
>     "package": "v3.1.0-rc3-7-g87a45d86ed"}, "capabilities": []}}
>     {'execute':'qmp_capabilities'}
>     {"return": {}}
>     {'execute':'blockdev-add','arguments':{'driver':'null-co',
>      'node-name':'foo','node-name':'bar'}}
>     {"return": {}}
>     {'execute':'query-named-block-nodes'}
>     {"return": [{ [...] "node-name": "bar" [...] }]}
>
> Reproducer #2 is iotest 229.
>
> Fix the parser to reject duplicates, and fix iotest 229 not to use
> them.
>
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Queued.
