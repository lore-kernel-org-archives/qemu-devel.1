Received: from eggs.gnu.org ([2001:4830:134:3::10]:34398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX37c-0003iP-LZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX37b-0005zt-Nk
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:19:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dX37b-0005wM-IK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:19:23 -0400
Date: Mon, 17 Jul 2017 12:19:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170717101906.GC5301@noname.redhat.com>
References: <1499952476-3454-1-git-send-email-armbru@redhat.com>
	<1499952476-3454-7-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499952476-3454-7-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PULL 6/9] Convert error_report() to warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Rob Herring <robh@kernel.org>, Josh Durgin <jdurgin@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Lieven <pl@kamp.de>, Greg Kurz <groug@kaod.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Chubb <peter.chubb@nicta.com.au>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>

Am 13.07.2017 um 15:27 hat Markus Armbruster geschrieben:
> From: Alistair Francis <alistair.francis@xilinx.com>
> 
> Convert all uses of error_report("warning:"... to use warn_report()
> instead. This helps standardise on a single method of printing warnings
> to the user.
> 
> All of the warnings were changed using these two commands:
>     find ./* -type f -exec sed -i \
>       's|error_report(".*warning[,:] |warn_report("|Ig' {} +
> 
> Indentation fixed up manually afterwards.
> 
> The test-qdev-global-props test case was manually updated to ensure that
> this patch passes make check (as the test cases are case sensitive).

This patch broke qemu-iotests 051 because it neglected to update the
reference output. Not sure if a change of the message was even intended,
but with a error location prefix, the order changes:

-(qemu) QEMU_PROG: -drive if=scsi,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
+(qemu) warning: qemu-system-x86_64: -drive if=scsi,media=cdrom: bus=0,unit=0 is deprecated with this machine type

Personally, I would expect the error location or at least the program
name to come first even for warnings.

Kevin
