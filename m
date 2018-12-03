Received: from eggs.gnu.org ([2001:4830:134:3::10]:44973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTrCp-000417-Nz
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTrCl-0007sJ-NP
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:36:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gTrCl-0007rt-HG
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:36:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C985D3084218
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 16:36:18 +0000 (UTC)
References: <f60b8f1e-979b-4af9-7b48-a691c1937f6a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4dd4e70a-7129-722c-971a-1b9f8b9aa349@redhat.com>
Date: Mon, 3 Dec 2018 10:36:17 -0600
MIME-Version: 1.0
In-Reply-To: <f60b8f1e-979b-4af9-7b48-a691c1937f6a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QMP accepts double dict keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 12/3/18 10:30 AM, Max Reitz wrote:
> Hi,
> 
> QMP accepts double keys in dicts without complaining.  The value it is
> using is apparently the last one specified:

JSON says it is undefined what happens when a client passes double keys. 
  We are probably best off if we teach our parser to be strict and 
reject doubled keys in QMP as invalid.

Hmm - can a client abuse QMP with duplicate keys to cause qemu to leak 
memory?

> 
> $ qemu-system-x86_64 -qmp stdio
> {"QMP": {"version": {"qemu": {"micro": 93, "minor": 0, "major": 3},
> "package": "v3.1.0-rc3-7-g87a45d86ed"}, "capabilities": []}}
> {'execute':'qmp_capabilities'}
> {"return": {}}
> {'execute':'blockdev-add','arguments':{'driver':'null-co',
>   'node-name':'foo','node-name':'bar'}}
> {"return": {}}
> {'execute':'query-named-block-nodes'}
> {"return": [{ [...] "node-name": "bar" [...] }]}
> 
> Another test case is iotest 229 which specifies both mode=absolute-paths
> and mode=existing (it wants the latter).
> 
> Max
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
