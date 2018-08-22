Received: from eggs.gnu.org ([2001:4830:134:3::10]:56545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fsbFJ-0006QP-4B
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fsbFE-00018p-58
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:04:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fsbFD-00017y-S6
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:04:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7MM44jH030059
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 18:04:49 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2m1dy253vd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 18:04:49 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Wed, 22 Aug 2018 18:04:47 -0400
Date: Wed, 22 Aug 2018 19:04:40 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20180821210024.3587-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821210024.3587-1-danielhb413@gmail.com>
Message-Id: <20180822220440.GA5287@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/2] HMP/snapshot changes - do not
 use ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

Hi, Daniel.

On Tue, Aug 21, 2018 at 06:00:22PM -0300, Daniel Henrique Barboza wrote:
> I am marking the patch series as "RFC" because it was supposed to be
> a discussion but, when I was investigating, it turned out to be
> easier to send the patches right away.
> 
> It is not uncommon to see bugs being opened by testers that attempt to
> create VM snapshots using HMP. It turns out that "0" and "1" are quite
> common snapshot names and they trigger a lot of bugs. I gave an example
> in the commit message of patch 1, but to sum up here: QEMU treats the
> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. It
> is documented as such, but this can lead to strange situations.
> 
> Given that it is strange for an API to consider a parameter to be 2 fields
> at the same time, and inadvently treating them as one or the other, and
> that removing the ID field is too drastic, my idea here is to keep the
> ID field for internal control, but do not let the user set it.
> 
> I guess there's room for discussion about considering this change an API
> change or not. It doesn't affect users of HMP and it doesn't affect Libvirt,
> but I am simplifying the meaning of the parameters of savevm/loadvm/delvm.

What if we harden ->id_str to be a UUID?

The example you mentioned is that user gave a snapshot the name "1", which was
the ->id_str of the first snapshot created.

If we harden ->id_str to be a UUID, that situation would only happen if user
entered a UUID already in use or a tag of their preference.  It would be a bit
harder for user to guess an ->id_str (UUID) by mistake.

So, in this example, the name "1" of the second snapshot wouldn't match the
->id_str of the first snapshot and a second snapshot (with a different UUID)
would be created with tag "1".

Having *_snapshot_find() to still match ->id_str or ->name is good for user
experience, where short names or tags can still be used to operate on snapshots.

Internally, code could handle only UUIDs of the snapshots.  So
*_snapshot_delete() would receive a UUID, and *_snapshot_find() would still
match ->id_str or ->name, still allowing savevm/loadvm/delvm to operate on both
IDs and tags.

> 
> 
> Daniel Henrique Barboza (2):
>   block/snapshot.c: eliminate use of ID input in snapshot operations
>   qcow2-snapshot: remove redundant find_snapshot_by_id_and_name call
> 
>  block/qcow2-snapshot.c |  5 -----
>  block/snapshot.c       |  5 +++--
>  hmp-commands.hx        | 20 ++++++++++----------
>  3 files changed, 13 insertions(+), 17 deletions(-)
> 
> -- 
> 2.17.1
> 
> 

-- 
Murilo
