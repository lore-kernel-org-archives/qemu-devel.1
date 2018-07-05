Received: from eggs.gnu.org ([2001:4830:134:3::10]:36279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb7FT-00014a-Kw
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb7FS-0007hc-Hp
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:36:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43948 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fb7FS-0007gc-D6
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:36:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3E3E72646
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 16:36:49 +0000 (UTC)
References: <20180705091402.26244-1-armbru@redhat.com>
	<20180705091402.26244-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <312a3c3e-b8bf-ebd2-5bc2-589eae7d56b4@redhat.com>
Date: Thu, 5 Jul 2018 11:36:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180705091402.26244-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: Do not expose "allow-preconfig"
 in query-qmp-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com

On 07/05/2018 04:14 AM, Markus Armbruster wrote:
> According to commit 047f7038f58, option --preconfig
> 
>      [...] allows pausing QEMU in the new RUN_STATE_PRECONFIG state,
>      allowing the configuration of QEMU from QMP before the machine
>      jumps into board initialization code of machine_run_board_init()
> 
>      The intent is to allow management to query machine state and
>      additionally configure it using previous query results within one
>      QEMU instance (i.e. eliminate the need to start QEMU twice, 1st to
>      query board specific parameters and 2nd for actual VM start using
>      query results for additional parameters).
> 

> 
> The command flag is exposed in query-qmp-schema (also commit
> d6fe3d02e9a).  This makes it ABI.
> 
> I consider the whole thing an offensively ugly hack, but sometimes an
> ugly hack is the best we can do to solve a problem people have.
> 
> The need described by the commit message quote above is genuine.  The
> proper solution would be a main loop that permits complete
> configuration via QMP.  This is out of reach, thus the hack.
> 

> Revert exactly (4), plus a bit of documentation added to
> qemu-tech.info in commit 047f7038f58.
> 
> Shrinks query-qmp-schema's output from 126.5KiB to 121.8KiB for me.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/introspect.json       | 5 +----
>   qemu-tech.texi             | 3 ---
>   scripts/qapi/introspect.py | 3 +--
>   3 files changed, 2 insertions(+), 9 deletions(-)

Good reasons for not baking it into the ABI just yet (similar to how we 
did not bake OOB into the 2.12 ABI).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
