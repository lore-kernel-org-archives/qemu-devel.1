Received: from eggs.gnu.org ([2001:4830:134:3::10]:35934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNHHA-00075g-6u
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNHH6-0003by-6H
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:01:40 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:35851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1gNHH5-0003WM-Tb
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:01:36 -0500
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 15 Nov 2018 14:01:08 +0100
Message-Id: <cover.1542285958.git.simon@ruderich.org>
In-Reply-To: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v6 0/6] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Simon Ruderich <simon@ruderich.org>

Hello,

As I got no replies to my last mails, here again the full patch
set (rebased on current master) in the hope to get this merged.
The first few patches are cleanup, the last two patches add the
pmemload feature. Only 5/6 requires an ack (although all
mentioned issues should be fixed), all other patches were already
reviewed in the last round.

If there's anything else I can do to get this merged, please tell
me.

Regards
Simon Ruderich

Simon Ruderich (6):
  cpus: convert qmp_memsave/qmp_pmemsave to use qemu_open
  cpus: use size_t in qmp_memsave/qmp_pmemsave
  hmp: use l for size argument in memsave/pmemsave
  hmp: use F for filename arguments in memsave/pmemsave
  qmp: add pmemload command
  hmp: add pmemload command

 cpus.c          | 79 +++++++++++++++++++++++++++++++++++++++++--------
 hmp-commands.hx | 18 +++++++++--
 hmp.c           | 16 ++++++++--
 hmp.h           |  1 +
 qapi/misc.json  | 20 +++++++++++++
 5 files changed, 118 insertions(+), 16 deletions(-)

Diff between v5 and v6:

    --- a/qapi/misc.json
    +++ b/qapi/misc.json
    @@ -1201,7 +1201,7 @@
    #
    # Returns: Nothing on success
    #
    -# Since: 3.1
    +# Since: 3.2
    ##
    { 'command': 'pmemload',
    'data': {'val': 'int', 'filename': 'str', '*size': 'int', '*offset': 'int'} }

Diff between v4 (last full series) and v6:

    --- a/cpus.c
    +++ b/cpus.c
    @@ -2473,6 +2473,10 @@ void qmp_pmemload(int64_t addr, const char *filename,
                error_setg_errno(errp, errno, "could not fstat fd to get size");
                goto exit;
            }
    +        if (S_ISCHR(s.st_mode) || S_ISBLK(s.st_mode)) {
    +            error_setg(errp, "pmemload doesn't support char/block devices");
    +            goto exit;
    +        }
            size = s.st_size;
        }

    --- a/qapi/misc.json
    +++ b/qapi/misc.json
    @@ -1201,7 +1201,7 @@
    #
    # Returns: Nothing on success
    #
    -# Since: 3.1
    +# Since: 3.2
    ##
    { 'command': 'pmemload',
    'data': {'val': 'int', 'filename': 'str', '*size': 'int', '*offset': 'int'} }

-- 
2.19.1
