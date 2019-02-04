Received: from eggs.gnu.org ([209.51.188.92]:39449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gqfBB-0005Lr-LC
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gqf7J-0006dq-6P
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:20:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1gqf7I-0006ci-Ti
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:20:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63C0C12794A
	for <qemu-devel@nongnu.org>; Mon,  4 Feb 2019 14:11:55 +0000 (UTC)
Date: Mon, 4 Feb 2019 15:11:24 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190204141124.GJ5349@paraplu.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Regression: Nested JSON structs in 'qmp-shell'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com

Hi,

Just noticed that this commit fcfab7541 ("qmp-shell: learn to send
commands with quoted arguments"), which introduces the usage of Python
'shlex' to handle quoted arguments, but it accidentally broke generation
of nested JSON structs.

With commit fcfab7541, you'll see the following brokenness:

    (QEMU) blockdev-create job-id=job0 options={"driver":"qcow2","size":16384,"file":{"driver":"file","filename":"foo.qcow2"}}
    {
        "execute": "blockdev-create", 
        "arguments": {
            "job-id": "job0", 
            "options": "{driver:qcow2,size:16384,file:{driver:file,filename:foo.qcow2}}"
        }
    }
    {
        "error": {
            "class": "GenericError", 
            "desc": "Invalid parameter type for 'options', expected: object"
        }
    }


If I revert commit fcfab7541, then the same 'qmp-shell' invocation
generates the _correct_ nested JSON:

    (QEMU) blockdev-create job-id=job0 options={"driver":"qcow2","size":16384,"file":{"driver":"file","filename":"foo.qcow2"}}                                                                    
    {                                                                                                                                                                                             
        "execute": "blockdev-create",                                                                                                                                                             
        "arguments": {                                                                                                                                                                            
            "job-id": "job000000000",                                                                                                                                                                     
            "options": {                                                                                                                                                                          
                "driver": "qcow2",                                                                                                                                                                
                "file": {                                                                                                                                                                         
                    "driver": "file",                                                                                                                                                             
                    "filename": "foo.qcow2"                                                                                                                                                       
                },                                                                                                                                                                                
                "size": 16384
            }                                                                                                                                                                                     
        }                                                                                                                                                                                         
    }                                                                                                                                                                                             
    {                                                                                                                                                                                             
        "return": {}                                                                                                                                                                              
    }                      


-- 
/kashyap
