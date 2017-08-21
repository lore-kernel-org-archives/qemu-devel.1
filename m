Received: from eggs.gnu.org ([2001:4830:134:3::10]:40944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1djmhq-0002oB-Q3
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1djmhm-0006Cp-Rf
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:25:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1djmhm-0006B4-LP
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:25:22 -0400
Date: Mon, 21 Aug 2017 15:25:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170821152513.1c59d3ec@nial.brq.redhat.com>
In-Reply-To: <6d8a9fae-fce8-c739-3e23-293cd201b91f@cn.fujitsu.com>
References: <1502847935-20483-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<9e5b10ce-6259-a21b-01dc-13f57d28a0ef@cn.fujitsu.com>
	<20170818164852.GZ3108@localhost.localdomain>
	<e67b5c35-5077-2603-f0ca-6abcade205db@cn.fujitsu.com>
	<20170821105708.4391e201@nial.brq.redhat.com>
	<6d8a9fae-fce8-c739-3e23-293cd201b91f@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] hw/acpi-build: Fix SRAT memory building
 when there is no memory in node0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com

On Mon, 21 Aug 2017 19:23:35 +0800
Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

> Hi, Igor
> 
> [...]
> >>
> >> Ok, I will do it right now.  
> >
> > see commit 6b9c1dd2c for example of adding test case,
> > currently test has base SRAT tables that is reused by all tests.
> > When you create testcase that produces different SRAT table,
> > 'make check' will print warnings that ables do not match
> > you can add "V=1" env. var. 'make V=1 check' to get detailed
> > diff of what's changed.
> >
> > also see how 'test_data.variant' is handled to get idea how to use
> > it to differentiate specific test case vs shared ACPI tables baseline blobs.
> >  
> 
> Thanks for teaching me that, it's very helpful to me.
> 
> Except for adding a new case, can we except memhp testcase with
> node RAM check? just like following shows:
then you'll lose SRAT with even distribution between nodes.
Just add an additional variant for your usecase.

> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 564da45..c79ece4 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -788,7 +788,7 @@ static void test_acpi_q35_tcg_memhp(void)
>       data.machine = MACHINE_Q35;
>       data.variant = ".memhp";
>       test_acpi_one(" -m 128,slots=3,maxmem=1G"
> -                  " -numa node -numa node"
> +                  " -numa node -numa node,mem=128"
>                     " -numa dist,src=0,dst=1,val=21",
>                     &data);
>       free_test_data(&data);
> @@ -802,7 +802,7 @@ static void test_acpi_piix4_tcg_memhp(void)
>       data.machine = MACHINE_PC;
>       data.variant = ".memhp";
>       test_acpi_one(" -m 128,slots=3,maxmem=1G"
> -                  " -numa node -numa node"
> +                  " -numa node -numa node,mem=128"
>                     " -numa dist,src=0,dst=1,val=21",
>                     &data);
>       free_test_data(&data);
> 
> 
> Thanks,
> 	dou.
> 
> 
