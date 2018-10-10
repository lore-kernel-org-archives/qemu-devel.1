Received: from eggs.gnu.org ([2001:4830:134:3::10]:58739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gAHJU-0000xd-UQ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gAHJR-0004AD-NQ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:26:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gAHJR-00048S-7v
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:26:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04DE781102
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 16:26:13 +0000 (UTC)
References: <20181009062718.1914-1-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <902c92e2-3454-771e-51ff-ab38b970e86e@redhat.com>
Date: Wed, 10 Oct 2018 11:26:05 -0500
MIME-Version: 1.0
In-Reply-To: <20181009062718.1914-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 0/6] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 10/9/18 1:27 AM, Peter Xu wrote:
> Based-on: <20180828191048.29806-1-armbru@redhat.com>
> Based-on: <20180901111716.1675-1-armbru@redhat.com>
> 
> (this series is based on Markus's monitor-next tree)
> 
> v9:
> - add r-bs
> - release the qmp queue lock before resume [Marc-Andre]

I haven't reviewed closely, but did want to report that I tested that 
with your patches applied, there is no way to trigger OOB of the initial 
capability handshake (good). It's a bit odd that the initial error 
(input member unexpected) is different from the later error (does not 
support OOB), but not a show-stopper, so I don't think you need to worry 
about it:

{"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 3}, 
"package": "v3.0.0-1150-g7d932cd3d53"}, "capabilities": ["oob"]}}
{"exec-oob":"qmp_capabilities","arguments":{"enable":["oob"]}}
{"error": {"class": "GenericError", "desc": "QMP input member 'exec-oob' 
is unexpected"}}
{"execute":"qmp_capabilities","arguments":{"enable":["oob"]}}
{"return": {}}
{"exec-oob":"qmp_capabilities"}
{"error": {"class": "GenericError", "desc": "The command 
qmp_capabilities does not support OOB"}}

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
