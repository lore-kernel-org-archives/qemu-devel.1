Received: from eggs.gnu.org ([2001:4830:134:3::10]:33425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cTn2F-0001JD-7T
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 05:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cTn2A-0005ep-VF
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 05:00:07 -0500
Date: Wed, 18 Jan 2017 10:59:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170118095952.GA5258@noname.str.redhat.com>
References: <1477926350-15869-1-git-send-email-ashijeetacharya@gmail.com>
	<20161031172022.GD12558@noname.redhat.com>
	<50472f2d-4a71-5f6b-1037-bbefd2d8f4f4@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50472f2d-4a71-5f6b-1037-bbefd2d8f4f4@kamp.de>
Subject: Re: [Qemu-devel] [PATCH v6 0/2] allow blockdev-add for NFS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: Ashijeet Acharya <ashijeetacharya@gmail.com>, eblake@redhat.com, jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 17.01.2017 um 16:14 hat Peter Lieven geschrieben:
> Am 31.10.2016 um 18:20 schrieb Kevin Wolf:
> >Am 31.10.2016 um 16:05 hat Ashijeet Acharya geschrieben:
> >>Previously posted series patches:
> >>v5: https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07580.html
> >>v4: https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07449.html
> >>v3: https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg06903.html
> >>v2: https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg05844.html
> >>v1: https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg04487.html
> >>
> >>This series adds blockdev-add support for NFS block driver.
> >Thanks, fixed as commented on patch 1 and applied.
> 
> Hi,
> 
> it seems this series breaks passing options via URI.
> 
> 1) in nfs_parse_uri
> 
> parse_uint_full(qp->p[i].value, NULL, 0)
> 
> segfaults, as the routine wants to set *NULL = val.

Yes, you're right.

> 2) all parameters that have a different names in options and qdict
> e.g. readahead-size vs. readahead cannot be passed via URI.
> 
> $ qemu-img convert -p nfs://172.21.200.61/templates/VC_debian8-20170116.qcow2,linux\?readahead=131072 iscsi://172.21.200.56:3260/iqn.2001-05.com.equallogic:0-8a0906-69d384e0a-aa3004e55e15878d-XXX/0
> 
> qemu-img: Could not open 'nfs://172.21.200.61/vcore-dev-cdrom/templates/VC_debian8-20170116.qcow2,linux?readahead=131072': Block protocol 'nfs' doesn't support the option 'readahead-size'
> 
> Please let me know if the below fix would be correct:

No, this needs to be fixed the other way round: runtime_opts must use
the names as specified in the schema, and nfs_client_open() must access
them as such. Without that, blockdev-add can't work (and the command
line only with the "wrong" old option names from the URL, whereas it
should be using the same names as the QAPI schema).

Kevin
