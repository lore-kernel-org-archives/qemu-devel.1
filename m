Received: from eggs.gnu.org ([2001:4830:134:3::10]:38312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dDAYS-000185-I3
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dDAYJ-00068p-4J
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:12:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dDAYI-000687-U0
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:12:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F5393680E
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 14:12:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170520020914.14562-1-ehabkost@redhat.com>
Date: Tue, 23 May 2017 16:12:43 +0200
In-Reply-To: <20170520020914.14562-1-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Fri, 19 May 2017 23:09:11 -0300")
Message-ID: <87o9uj64ro.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC 0/3] qmp: Return extra information on
 qom-list-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> This series adds 'abstract' and 'parent-types' fields to the
> output of qom-list-types.

Peeking at PATCH 3, it looks like 'parent-types' is the transitive
closure of the single direct parent type (TypeImpl member parent_type).
Do we need information on interfaces as well?

> For reference, below are the sizes of the output of
> "qom-list-types abstract=true" on qemu-system-x86_64, before and
> after applying the patches:
>
> * before: 11724 bytes
> * with 'abstract' field: 20119 bytes
> * with 'abstract' and 'parent-types': 44383 bytes

Obvious ways to save space:

* Make 'abstract' optional, default to false, present only when
  necessary (79 out of 456 times right now)

* Pare down 'parent-types' to *direct* parent types.  The indirect ones
  are redundant.

A less obvious way:

* 'parent-types' defines a relation with adjacency lists.  If the
  relation is tree-shaped, we can send the tree instead, i.e. a tree of
  device names rather than list of (device name, adjacency list).  New
  command unless we're willing to break qom-list-types.

> I'm not sure if extending qom-list-types with this info is the
> right way to go, or if we should keep qom-list-types as-is and
> add a new "query-qom-type" QMP command to query info on one QOM
> type at a time.

Might lead to more traffic rather than less.  Depends on what
information the client needs to query.
