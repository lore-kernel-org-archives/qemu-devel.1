Received: from eggs.gnu.org ([2001:4830:134:3::10]:52407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdFNV-0000yh-Ps
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdFNU-00018N-Bq
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:05:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdFNU-000173-6R
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:05:08 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20161027153217.16984-4-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Thu, 27 Oct 2016 16:32:12 +0100")
References: <20161027153217.16984-1-dgilbert@redhat.com>
	<20161027153217.16984-4-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 13 Feb 2017 13:04:56 +0100
Message-ID: <87fuji70uv.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/8] migration: Add VMSTATE_WITH_TMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, duanj@linux.vnet.ibm.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> VMSTATE_WITH_TMP is for handling structures where some calculation
> or rearrangement of the data needs to be performed before the data
> hits the wire.
> For example,  where the value on the wire is an offset from a
> non-migrated base, but the data in the structure is the actual pointer.
>
> To use it, a temporary type is created and a vmsd used on that type.
> The first element of the type must be 'parent' a pointer back to the
> type of the main structure.  VMSTATE_WITH_TMP takes care of allocating
> and freeing the temporary before running the child vmsd.
>
> The post_load/pre_save on the child vmsd can copy things from the parent
> to the temporary using the parent pointer and do any other calculations
> needed; it can then use normal VMSD entries to do the actual data
> storage without having to fiddle around with qemu_get_*/qemu_put_*
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

My idea was to do the other way around.

But as you beat me with the idea.

Reviewed-by: Juan Quintela <quintela@redhat.com>


Bascially what I created was a VMSTATE_SYNTHETIC() where the field value
is null.  You create a new get/put functions for the special values.


But looking for far away it is basically the same, I just preffered the
name O:-)

Later, Juan
