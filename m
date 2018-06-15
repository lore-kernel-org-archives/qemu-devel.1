Received: from eggs.gnu.org ([2001:4830:134:3::10]:33197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTm5X-00075A-O3
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTm5X-0006rE-19
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:36:15 -0400
Date: Fri, 15 Jun 2018 12:36:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180615103607.GB5187@localhost.localdomain>
References: <20180614191443.14361-1-armbru@redhat.com>
	<20180614191443.14361-10-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614191443.14361-10-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/18] block: Make remaining uses of
 qobject input visitor more robust
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

Am 14.06.2018 um 21:14 hat Markus Armbruster geschrieben:
> Remaining uses of qobject_input_visitor_new_keyval() in the block
> subsystem:
> 
> * block_crypto_create_opts_init()

Still the wrong function name. Will fix this while applying. (Should be
block_crypto_open_opts_init())

>   Currently doesn't visit any non-string scalars, thus safe.  It's
>   called from
>   - block_crypto_open_luks()
>     Creates the QDict with qemu_opts_to_qdict_filtered(), which
>     creates only string scalars, but has a TODO asking for other types.
>   - qcow_open()
>   - qcow2_open(), qcow2_co_invalidate_cache(), qcow2_reopen_prepare()
> 
> * block_crypto_create_opts_init(), called from
>   - block_crypto_co_create_opts_luks()
>     Also creates the QDict with qemu_opts_to_qdict_filtered().
> 
> * vdi_co_create_opts()
>   Also creates the QDict with qemu_opts_to_qdict_filtered().
> 
> Replace these uses by qobject_input_visitor_new_flat_confused() for
> robustness.  This adds crumpling.  Right now, that's a no-op, but if
> we ever extend these things in non-flat ways, crumpling will be
> needed.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Kevin
