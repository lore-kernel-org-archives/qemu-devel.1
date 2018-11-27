Received: from eggs.gnu.org ([2001:4830:134:3::10]:39083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRdO1-0005nZ-Bj
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRdLA-0004S0-S5
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:23:51 -0500
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:49858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gRdLA-0004R5-ME
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:23:48 -0500
Received: from player168.ha.ovh.net (unknown [10.109.160.253])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 2EA31146092
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 14:23:46 +0100 (CET)
Date: Tue, 27 Nov 2018 14:23:37 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181127142337.4effe245@bahia.lan>
In-Reply-To: <4c274aa6-90e9-bf8f-c0d0-55c7553e472b@redhat.com>
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<4c274aa6-90e9-bf8f-c0d0-55c7553e472b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/9] ppc: get rid of
 g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>

On Tue, 27 Nov 2018 07:16:44 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 11/27/18 7:04 AM, Greg Kurz wrote:
> > As explained in HACKING, the g_malloc(sizeof(T) * n) construct is unsafe
> > because it can't detect multiplication overflowing size_t and doesn't
> > allow type checking.
> > 
> > It appears to be used in a bunch of places though:
> > 
> > $ git grep -E 'malloc.*sizeof' | grep ' \* '  | wc -l
> > 101
> > 
> > This series fixes the ppc target and ppc machine code. The changes are
> > mostly trivial. Only the mac99 and e500 machines required some more work
> > that should be reviewed carefully, as it was only compile-tested.  
> 
> Did you do this all manually, or did you try to use Coccinelle?  Hmm - 
> we have a Coccinelle script for this mentioned in commit b45c03f (most 
> recently reused in bdd81add) - but it is not yet in scripts/coccinelle/. 
>   Maybe that would be worth doing now.
> 

I did that manually because I didn't know about Markus's Coccinelle
script... Also, I've only fixed the case involving a multiplication,
since HACKING says "g_malloc(sizeof(*v)) are acceptable".

I'll have a look at adding the script in scripts/coccinelle/.

Cheers,

--
Greg
