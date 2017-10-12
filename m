Received: from eggs.gnu.org ([2001:4830:134:3::10]:58839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2cUy-00040R-JV
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2cUv-0002jW-EI
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:22:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e2cUv-0002it-7d
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:21:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D30B267F5
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 12:21:56 +0000 (UTC)
Date: Thu, 12 Oct 2017 14:21:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171012142153.125b5bd8@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QAPI magician wanted ...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>


I'm working on introducing QMP command to set numa mappings
via QMP interface at runtime instead of CLI.

I'd prefer to reuse NumaOptions for parsing input,
but I can't wrap my head around QAPI magic.

So far I've added new command in qapi-schema.json:

  {
    'command': 'set-numa-node',                                                    
    'data': {'cmd': 'NumaOptions'}                                                 
  }

it at least compiles and manages to handle input without union part

  { "execute": "set-numa-node", "arguments": { "cmd": { "type": "node" } } }

however I can't figure out syntax that adds union part to it,
I have tried something like this

  { "execute": "set-numa-node", "arguments": { "cmd": { "type": "node", "node" : { "nodeid": 1 } } } }

but it errors out with

  {"error": {"class": "GenericError", "desc": "Parameter 'cmd.node' is unexpected"}}

Any advice on how to make it work if possible at all or
alternative ways how to achieve the end goal.
