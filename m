Received: from eggs.gnu.org ([2001:4830:134:3::10]:33455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG1Ty-0006Fr-R1
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG1Tt-0003q7-EZ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:08:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dG1Tt-0003pk-8T
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:08:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170531070438.14081-1-maozy.fnst@cn.fujitsu.com>
Date: Wed, 31 May 2017 13:07:52 +0200
In-Reply-To: <20170531070438.14081-1-maozy.fnst@cn.fujitsu.com> (Mao Zhongyi's
	message of "Wed, 31 May 2017 15:04:38 +0800")
Message-ID: <87o9u9cmif.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] pci: Fix unreasonable return value check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, mst@redhat.com

This is cleanup, not a bug fix, so:

    pci: Clean up error checking in pci_add_capability()

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

> The return value of pci_add_capability2() is only 2 cases, positive
> on success, nagetive on failure and set error message to Error. In

negative

> other worlds, If Error is filled, the return value must be nagetive.

words, if

> There is no case where errp is set but the return value is a positive.
> But pci_add_capability() does. So the return value check is illogical.

pci_add_capability2() could use a function comment explaining its return
value.  Not this patch's job.

> Meanwhile, all other callers of pci_add_capability2() do the same
> check as this patch. So fix it.

Suggest:

    pci: Clean up error checking in pci_add_capability()

  On success, pci_add_capability2() returns a positive value.  On
  failure, it sets an error and returns a negative value.

  pci_add_capability() laboriously checks this behavior.  No other
  caller does.  Drop the checks from pci_add_capability().

> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  hw/pci/pci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 259483b..1faf060 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2269,12 +2269,8 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
>      Error *local_err = NULL;
>  
>      ret = pci_add_capability2(pdev, cap_id, offset, size, &local_err);
> -    if (local_err) {
> -        assert(ret < 0);
> +    if (ret < 0) {
>          error_report_err(local_err);
> -    } else {
> -        /* success implies a positive offset in config space */
> -        assert(ret > 0);
>      }
>      return ret;
>  }

Many functions return distinct error values in addition to setting an
error.  We usually check one of the two, and assume the other is sane.
This is one of the few places where we assert it is.  Not wrong, just
cumbersome.  I'd prefer to drop the assertions, i.e. take this patch.
But it's up to the PCI maintainers.
