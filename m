Received: from eggs.gnu.org ([2001:4830:134:3::10]:48807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fSiq6-0005WB-FE
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fSiq4-0001X0-NZ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:55:58 -0400
Date: Tue, 12 Jun 2018 08:55:48 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180612125548.GA19946@localhost.localdomain>
References: <20180607062559.16127-1-armbru@redhat.com>
	<20180607213303.GJ6435@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607213303.GJ6435@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC PATCH 00/19] block: Configuration fixes and
 rbd authentication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

On Thu, Jun 07, 2018 at 05:33:03PM -0400, Jeff Cody wrote:
> On Thu, Jun 07, 2018 at 08:25:40AM +0200, Markus Armbruster wrote:
> > This series is RFC because:
> > 
> > * It clashes with parts of Max's "[PATCH 00/13] block: Try to create
> >   well typed json:{} filenames".  I missed that one until too late,
> >   sorry.
> > 
> >   - I stole "[PATCH 06/13] block: Add block-specific QDict header",
> >     and tacked on fixups I'd like to have.
> > 
> >   - My qobject_input_visitor_new_flat_confused() addresses the same
> >     general problem as Max's qdict_stringify_for_keyval(): the block
> >     layer's confused use of QObject types.  My solution fixes a number
> >     of bugs in -blockdev, blockdev-add and -drive.  If Max's solution
> >     adds further value, we need to merge the two somehow.
> > 
> >   - I changed qdict_flatten() to fix -blockdev and blockdev-add for
> >     empty objects and arrays.  Max fixed it to not mess up shallow
> >     clones.  We need to merge the two.
> > 
> > * Rbd testing is incomplete.  Jeff Cody volunteered to test on his
> >   rig.  Results should be in soon.
> > 
> 
> Here are some results from auth testing of various combinations; I haven't
> completed all the combinations in my matrix yet, but what I have completed
> looks like what I would expect.
> 
> These were all tested with blockdev-add QAPI commands against this patch
> series.
> 
> I'll be away on PTO tomorrow (Friday), so I'll conclude testing on Monday.
> 
> Warning, long lines below, so don't read it on a vt220 (apologies in
> advance if you do...):
> 

Below is the rest of the matrix filled out.  Everything looks OK to me, the
ones that were a bit different than I expected were when the server was
'none', and we passed an bad key-secret.  But that isn't a qemu/qapi issue,
and not really an issue at all (just different from what I expected).

Completed tests:


  Server    |                           Client-Side (qemu host)
------------+--------------------------------------------------------------------------------------------------
            |                                                                        |
ServerAuth  |   user        key-secret    /etc/ceph/keyring     auth-client-required | Result
------------+--------------------------------------------------------------------------------------------------
cephx, none |   ---         ---           ---                   ---                     {"return": {}}
cephx, none |   ---         ---           valid                 ---                     {"return": {}}
cephx, none |   ---         ---           invalid               ---                     {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx, none |   ---         valid         ---                   ---                     {"return": {}}
cephx, none |   ---         invalid       ---                   ---                     {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx, none |   ---         invalid       valid                 ---                     {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx, none |   ---         valid         invalid               ---                     {"return": {}}
cephx, none |   admin       ---           valid                 ---                     {"return": {}}
cephx, none |   admin       ---           invalid               ---                     {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx, none |   invalid     ---           valid                 ---                     {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx, none |   invalid     ---           invalid               ---                     {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}

cephx, none |   ---         ---           ---                   none                    {"return": {}}
cephx, none |   ---         ---           valid                 none                    {"return": {}}
cephx, none |   ---         ---           invalid               none                    {"return": {}}
cephx, none |   ---         valid         ---                   none                    {"return": {}}
cephx, none |   ---         invalid       ---                   none                    {"return": {}}
cephx, none |   ---         invalid       valid                 none                    {"return": {}}
cephx, none |   ---         valid         invalid               none                    {"return": {}}
cephx, none |   admin       ---           valid                 none                    {"return": {}}
cephx, none |   admin       ---           invalid               none                    {"return": {}}
cephx, none |   invalid     ---           valid                 none                    {"return": {}}
cephx, none |   invalid     ---           invalid               none                    {"return": {}}
            |
cephx, none |   ---         ---           ---                   cephx                   {"error": {"class": "GenericError", "desc": "error connecting: No such file or directory"}}
cephx, none |   ---         ---           valid                 cephx                   {"return": {}}
cephx, none |   ---         ---           invalid               cephx                   {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx, none |   ---         valid         ---                   cephx                   {"return": {}}
cephx, none |   ---         invalid       ---                   cephx                   {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx, none |   ---         invalid       valid                 cephx                   {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx, none |   ---         valid         invalid               cephx                   {"return": {}}
cephx, none |   admin       ---           valid                 cephx                   {"return": {}}
cephx, none |   invalid     ---           valid                 cephx                   {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx, none |   invalid     ---           invalid               cephx                   {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
            |
cephx, none |   ---         ---           ---                   cephx, none             {"return": {}}
cephx, none |   ---         ---           valid                 cephx, none             {"return": {}}
cephx, none |   ---         ---           invalid               cephx, none             {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx, none |   ---         valid         ---                   cephx, none             {"return": {}}
cephx, none |   ---         invalid       ---                   cephx, none             {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx, none |   ---         invalid       valid                 cephx, none             {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx, none |   ---         valid         invalid               cephx, none             {"return": {}}
cephx, none |   admin       ---           valid                 cephx, none             {"return": {}}
cephx, none |   invalid     ---           valid                 cephx, none             {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
            |
none        |   ---         ---           ---                   none                    {"return": {}}
none        |   ---         ---           valid                 none                    {"return": {}}
none        |   ---         ---           invalid               none                    {"return": {}}
none        |   ---         valid         ---                   none                    {"return": {}}
none        |   ---         invalid       ---                   none                    {"return": {}}
none        |   admin       ---           valid                 none                    {"return": {}}
none        |   invalid     ---           valid                 none                    {"return": {}}
            |
none        |   ---         ---           ---                   cephx                   {"error": {"class": "GenericError", "desc": "error connecting: No such file or directory"}}
none        |   ---         ---           valid                 cephx                   {"error": {"class": "GenericError", "desc": "error connecting: Operation not supported"}}
none        |   ---         ---           invalid               cephx                   {"error": {"class": "GenericError", "desc": "error connecting: Operation not supported"}}
none        |   ---         valid         ---                   cephx                   {"error": {"class": "GenericError", "desc": "error connecting: Operation not supported"}}
none        |   ---         invalid       ---                   cephx                   {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
none        |   admin       ---           valid                 cephx                   {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
none        |   invalid     ---           valid                 cephx                   {"error": {"class": "GenericError", "desc": "error connecting: Operation not supported"}}
            |
none        |   ---         ---           ---                   cephx, none             {"return": {}}
none        |   ---         ---           valid                 cephx, none             {"return": {}}
none        |   ---         ---           invalid               cephx, none             {"return": {}}
none        |   ---         valid         ---                   cephx, none             {"return": {}}
none        |   ---         invalid       ---                   cephx, none             {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
none        |   admin       ---           valid                 cephx, none             {"return": {}}
none        |   invalid     ---           valid                 cephx, none             {"return": {}}

cephx, none |   ---         ---           ---                   ---                     {"return": {}}
cephx, none |   ---         ---           valid                 ---                     {"return": {}}
            |
none        |   ---         ---           ---                   ---                     {"return": {}}
            |
cephx       |   ---         ---           ---                   ---                     {"error": {"class": "GenericError", "desc": "error connecting: Operation not supported"}}
cephx       |   ---         ---           valid                 ---                     {"return": {}}
cephx       |   ---         ---           invalid               ---                     {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx       |   ---         valid         ---                   ---                     {"return": {}}
cephx       |   ---         invalid       ---                   ---                     {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx       |   admin       ---           valid                 ---                     {"return": {}}
cephx       |   invalid     ---           valid                 ---                     {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
            |
cephx       |   ---         ---           ---                   none
cephx       |   ---         ---           valid                 none                    {"error": {"class": "GenericError", "desc": "error connecting: Operation not supported"}}
cephx       |   ---         ---           invalid               none                    {"error": {"class": "GenericError", "desc": "error connecting: Operation not supported"}}
cephx       |   ---         valid         ---                   none                    {"error": {"class": "GenericError", "desc": "error connecting: Operation not supported"}}
cephx       |   ---         invalid       ---                   none                    {"error": {"class": "GenericError", "desc": "error connecting: Operation not supported"}}
cephx       |   admin       ---           valid                 none                    {"error": {"class": "GenericError", "desc": "error connecting: Operation not supported"}}
cephx       |   invalid     ---           valid                 none                    {"error": {"class": "GenericError", "desc": "error connecting: Operation not supported"}}
            |
cephx       |   ---         ---           ---                   cephx                    {"error": {"class": "GenericError", "desc": "error connecting: No such file or directory"}}
cephx       |   ---         ---           valid                 cephx                    {"return": {}}
cephx       |   ---         ---           invalid               cephx                    {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx       |   ---         valid         ---                   cephx                    {"return": {}}
cephx       |   ---         invalid       ---                   cephx                    {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx       |   admin       ---           valid                 cephx                    {"return": {}}
cephx       |   invalid     ---           valid                 cephx                    {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
            |
cephx       |   ---         ---           ---                   cephx, none              {"error": {"class": "GenericError", "desc": "error connecting: Operation not supported"}}
cephx       |   ---         ---           valid                 cephx, none              {"return": {}}
cephx       |   ---         ---           invalid               cephx, none              {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx       |   ---         valid         ---                   cephx, none              {"return": {}}
cephx       |   ---         invalid       ---                   cephx, none              {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}
cephx       |   admin       ---           valid                 cephx, none              {"return": {}}
cephx       |   invalid     ---           valid                 cephx, none              {"error": {"class": "GenericError", "desc": "error connecting: Invalid argument"}}



> 
> 
> 
> 
> 
> > Perhaps the series should be split in two: PATCH 01-17 are
> > configuration fixes, PATCH 18-19 are rbd authentication work.  I may
> > still do that for the non-RFC patch submission.
> > 
> > Markus Armbruster (18):
> >   rbd: Drop deprecated -drive parameter "filename"
> >   iscsi: Drop deprecated -drive parameter "filename"
> >   fixup block: Add block-specific QDict header
> >   qobject: Move block-specific qdict code to block-qdict.c
> >   block: Fix -blockdev for certain non-string scalars
> >   block: Fix -drive for certain non-string scalars
> >   block: Clean up a misuse of qobject_to() in .bdrv_co_create_opts()
> >   block: Factor out qobject_input_visitor_new_flat_confused()
> >   block: Make remaining uses of qobject input visitor more robust
> >   block-qdict: Simplify qdict_flatten_qdict()
> >   block-qdict: Tweak qdict_flatten_qdict(), qdict_flatten_qlist()
> >   block-qdict: Clean up qdict_crumple() a bit
> >   block-qdict: Simplify qdict_is_list() some
> >   check-block-qdict: Rename qdict_flatten()'s variables for clarity
> >   check-block-qdict: Cover flattening of empty lists and dictionaries
> >   block: Fix -blockdev / blockdev-add for empty objects and arrays
> >   rbd: New parameter auth-client-required
> >   rbd: New parameter key-secret
> > 
> > Max Reitz (1):
> >   block: Add block-specific QDict header
> > 
> >  MAINTAINERS               |   2 +
> >  block.c                   |   1 +
> >  block/crypto.c            |   6 +-
> >  block/gluster.c           |   1 +
> >  block/iscsi.c             |  24 +-
> >  block/nbd.c               |  16 +-
> >  block/nfs.c               |   8 +-
> >  block/parallels.c         |  11 +-
> >  block/qcow.c              |  11 +-
> >  block/qcow2.c             |  11 +-
> >  block/qed.c               |  11 +-
> >  block/quorum.c            |   1 +
> >  block/rbd.c               |  85 +++--
> >  block/sheepdog.c          |  23 +-
> >  block/snapshot.c          |   1 +
> >  block/ssh.c               |  16 +-
> >  block/vdi.c               |   4 +-
> >  block/vhdx.c              |  11 +-
> >  block/vpc.c               |  11 +-
> >  block/vvfat.c             |   1 +
> >  block/vxhs.c              |   1 +
> >  blockdev.c                |   1 +
> >  include/block/qdict.h     |  34 ++
> >  include/qapi/qmp/qdict.h  |  17 -
> >  qapi/block-core.json      |  15 +
> >  qobject/Makefile.objs     |   1 +
> >  qobject/block-qdict.c     | 722 ++++++++++++++++++++++++++++++++++++++
> >  qobject/qdict.c           | 628 ---------------------------------
> >  tests/Makefile.include    |   4 +
> >  tests/check-block-qdict.c | 690 ++++++++++++++++++++++++++++++++++++
> >  tests/check-qdict.c       | 641 ---------------------------------
> >  tests/check-qobject.c     |   1 +
> >  tests/test-replication.c  |   1 +
> >  util/qemu-config.c        |   1 +
> >  34 files changed, 1573 insertions(+), 1439 deletions(-)
> >  create mode 100644 include/block/qdict.h
> >  create mode 100644 qobject/block-qdict.c
> >  create mode 100644 tests/check-block-qdict.c
> > 
> > -- 
> > 2.17.1
> > 
