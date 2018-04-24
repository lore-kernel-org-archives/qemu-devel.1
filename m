Received: from eggs.gnu.org ([2001:4830:134:3::10]:51628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fAwuh-0004Uf-Fj
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fAwuc-0003QA-Lf
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:19:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1fAwuc-0003Pd-DV
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:19:10 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3OCHiI2055751
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 08:19:09 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hj43nscnm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 08:19:08 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 24 Apr 2018 13:19:05 +0100
References: <1524470305-26484-1-git-send-email-thuth@redhat.com>
	<1524470305-26484-3-git-send-email-thuth@redhat.com>
	<06bd598b-7c14-03fc-9720-36a4b68f10b4@linux.vnet.ibm.com>
	<b3d9d176-94ca-70d3-27e8-1a9dc969a29a@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 24 Apr 2018 14:19:00 +0200
MIME-Version: 1.0
In-Reply-To: <b3d9d176-94ca-70d3-27e8-1a9dc969a29a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <d83e6950-a3f5-42ef-b71a-6325cefe660a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] pc-bios/s390-ccw/net: Add support
 for pxelinux-style config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

On 24.04.2018 13:23, Thomas Huth wrote:
> On 24.04.2018 13:07, Viktor VM Mihajlovski wrote:
>> On 23.04.2018 09:58, Thomas Huth wrote:
>>> Since it is quite cumbersome to manually create a combined kernel with
>>> initrd image for network booting, we now support loading via pxelinux
>>> configuration files, too. In these files, the kernel, initrd and command
>>> line parameters can be specified seperately, and the firmware then takes
>>> care of glueing everything together in memory after the files have been
>>> downloaded.
>>>
>>> The user can either specify a config file directly as bootfile via DHCP
>>> (but in this case, the file has to start either with "default" or a "#"
>>> comment so we can distinguish it from binary kernels), or a folder (i.e.
>>> the bootfile name must end with "/") where the firmware should look for
>>> the typical pxelinux.cfg file names based on MAC or IP address. If no
>>> direct file or folder has been specified, we still look for certain
>>> files in the default "pxelinux.cfg/" folder, but omit some of the file
>>> names to avoid to download x86 config files here by mistake.
>> I don't think this is necessary, since the DHCP server configuration
>> SHOULD take into consideration the processor architecture. In fact it is
>> even annoying and hard to understand that an attempt is made to load the
>> uuid, mac and "full ip" based config files but not the "abbreviated ip"
>> or default file.
> 
> If the DHCP server has been been properly configured to take the
> processor architecture into account, there should be a usable entry in
> the bootfile (i.e. either a binary, a config file or a folder where
> config files should be probed). So in this case the skipping does not
> take place.
> 
> And if you want the full probing in the pxelinux.cfg/ directory, you can
> also specify "pxelinux.xfg/" in the bootfile entry.
> 
> The skipping only happens if there is no valid entry in the bootfile,
> i.e. the server configuration was likely wrong anyway, and we just do
> some desperate final guesses with the default "pxelinux.cfg/" directory
> before giving up.
> 
My major concern is consistency. The emergency probing is different from
the normal one and this can be hell to debug (it took me a while to
understand what went wrong[1]).
I like the idea to improve the usability by doing a wild guess, but only
if it is consistent with the regular behavior.
>> After all, even if the config file for x86 was loaded,
>> the effect will be that the network boot fails (as it does now).
> 
> Ok, that's true, too.
> 
> Actually, I don't mind too much whether we probe the files based on the
> partial IP address or the "default" name, or whether we skip them. I
> thought it might be a good idea to avoid a potential clash with x86
> files, but if you think that this is rather confusing, I also see your
> point. So I'd say let's wait for some more opinions from others before
> we decide about the final behavior...
> 
>  Thomas
> 

[1] What I did was to keep my previous pxelinux configuration but delete
the pxelinux.0 file on the server to force the built-in processing.

-- 
Regards,
  Viktor Mihajlovski
