Received: from eggs.gnu.org ([2001:4830:134:3::10]:36203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUpi-0004tV-1C
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUph-0006i6-5s
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:54:46 -0400
Date: Tue, 18 Jul 2017 16:54:30 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170718155430.GQ11927@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-7-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1500385286-21142-7-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 06/10] hmp: Clean up and simplify
 hmp_migrate_set_parameter()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

On Tue, Jul 18, 2017 at 03:41:22PM +0200, Markus Armbruster wrote:
> The bulk of hmp_migrate_set_parameter()'s code sets one member of
> MigrationParameters according to the command's arguments.  It uses a
> string visitor for integer and boolean members, but not for string and
> size members.  It calls visit_type_bool() right away, but delays
> visit_type_int() some.  The delaying requires a flag variable and a
> bit of trickery: we set all integer members instead of just the one we
> want, and rely on the has_FOOs to mask the unwanted ones.
> 
> Clean this up as follows.  Don't delay calling visit_type_int().  Use
> the string visitor for strings, too.  This involves extra allocations
> and cleanup, but doing them is simpler and cleaner than avoiding them.
> 
> Sadly, using the string visitor for sizes isn't possible, because it
> defaults to Bytes rather than Mebibytes.  Add a comment explaining
> that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp.c | 78 ++++++++++++++++++++++++++++---------------------------------------
>  1 file changed, 32 insertions(+), 46 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
