Received: from eggs.gnu.org ([2001:4830:134:3::10]:52539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cipsA-0000WZ-B5
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:03:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cips9-0007hD-Gf
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:03:54 -0500
Date: Tue, 28 Feb 2017 23:03:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170228220346.GE4090@noname.redhat.com>
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
	<1488317230-26248-4-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488317230-26248-4-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/24] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Am 28.02.2017 um 22:26 hat Markus Armbruster geschrieben:
> keyval_parse() parses KEY=VALUE,... into a QDict.  Works like
> qemu_opts_parse(), except:
> 
> * Returns a QDict instead of a QemuOpts (d'oh).
> 
> * Supports nesting, unlike QemuOpts: a KEY is split into key
>   fragments at '.' (dotted key convention; the block layer does
>   something similar on top of QemuOpts).  The key fragments are QDict
>   keys, and the last one's value is updated to VALUE.
> 
> * Each key fragment may be up to 127 bytes long.  qemu_opts_parse()
>   limits the entire key to 127 bytes.
> 
> * Overlong key fragments are rejected.  qemu_opts_parse() silently
>   truncates them.
> 
> * Empty key fragments are rejected.  qemu_opts_parse() happily
>   accepts empty keys.
> 
> * It does not store the returned value.  qemu_opts_parse() stores it
>   in the QemuOptsList.
> 
> * It does not treat parameter "id" specially.  qemu_opts_parse()
>   ignores all but the first "id", and fails when its value isn't
>   id_wellformed(), or duplicate (a QemuOpts with the same ID is
>   already stored).  It also screws up when a value contains ",id=".
> 
> * Implied value is not supported.  qemu_opts_parse() desugars "foo" to
>   "foo=on", and "nofoo" to "foo=off".
> 
> * An implied key's value can't be empty, and can't contain ','.
> 
> I intend to grow this into a saner replacement for QemuOpts.  It'll
> take time, though.
> 
> Note: keyval_parse() provides no way to do lists, and its key syntax
> is incompatible with the __RFQDN_ prefix convention for downstream
> extensions, because it blindly splits at '.', even in __RFQDN_.  Both
> issues will be addressed later in the series.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
