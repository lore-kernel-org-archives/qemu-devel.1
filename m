Received: from eggs.gnu.org ([2001:4830:134:3::10]:47450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fBJKe-0003ii-PP
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fBJKc-0002Nw-1a
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:15:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fBJKb-0002N9-PM
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:15:29 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3PCF5cB009985
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:15:27 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hjqgmwqw8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:15:27 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 25 Apr 2018 13:15:23 +0100
References: <1524633715-21393-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 25 Apr 2018 14:15:18 +0200
MIME-Version: 1.0
In-Reply-To: <1524633715-21393-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f2024d4a-8bd8-c11c-d24b-f767f33023d4@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1] hw/s390x: Allow to configure the
 consoles with the "-serial" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 04/25/2018 07:21 AM, Thomas Huth wrote:
> The consoles ("sclpconsole" and "sclplmconsole") can only be configured
> with "-device" and "-chardev" so far. Other machines use the convenience
> option "-serial" to configure the default consoles, even for virtual
> consoles like spapr-vty on the pseries machine. So let's support this
> option on s390x, too. This way we can easily enable the serial console
> here again with "-nodefaults", for example:
> 
> qemu-system-s390x -no-shutdown -nographic -nodefaults -serial mon:stdio
> 
> ... which is way shorter than typing:
> 
> qemu-system-s390x -no-shutdown -nographic -nodefaults \
>   -chardev stdio,id=c1,mux=on -device sclpconsole,chardev=c1 \
>   -mon chardev=c1
> 
> The -serial parameter can also be used if you only want to see the QEMU
> monitor on stdio without using -nodefaults, but not the console output.
> That's something that is pretty impossible with the current code today:
> 
> qemu-system-s390x -no-shutdown -nographic -serial none
> 
> While we're at it, this patch also maps the second -serial option to the
> "sclplmconsole", so that there is now an easy way to configure this second
> console on s390x, too, for example:
> 
> qemu-system-s390x -no-shutdown -nographic -serial null -serial mon:stdio
> 
> Additionally, the new code is also smaller than the old one and we have
> less s390x-specific code in vl.c :-)
> 
> I've also checked that migration still works as expected by migrating
> a guest with console output back and forth between a qemu-system-s390x
> that has this patch and an instance without this patch.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Very nice. I tested some combinations (only limited test) and everything looks
good. 

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
