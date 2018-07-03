Received: from eggs.gnu.org ([2001:4830:134:3::10]:47877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAdL-00075G-HS
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAdG-0005jx-VT
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:01:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55882 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faAdG-0005jL-Qo
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:01:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A6F781A4EB9
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:01:30 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-15-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8055d3f1-b9e3-553c-7941-94af1233f5f6@redhat.com>
Date: Mon, 2 Jul 2018 21:01:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/32] qmp: Always free QMPRequest with
 qmp_request_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

On 07/02/2018 11:22 AM, Markus Armbruster wrote:
> monitor_qmp_dispatch_one() frees a QMPRequest manually, because it
> needs to keep a reference to ->id.  Premature optimization.  Take an
> additional reference so we can use qmp_request_free().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/monitor.c b/monitor.c
> index 10991757f6..94f5660c3c 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4181,8 +4181,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
>       id = req_obj->id;
>       need_resume = req_obj->need_resume;
>   
> -    g_free(req_obj);
> -
>       old_mon = cur_mon;
>       cur_mon = mon;
>   
> @@ -4191,14 +4189,14 @@ static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
>       cur_mon = old_mon;
>   
>       /* Respond if necessary */
> -    monitor_qmp_respond(mon, rsp, NULL, id);
> +    monitor_qmp_respond(mon, rsp, NULL, qobject_ref(id));

This requires qobject_ref(NULL) to work (I thought at one point we were 
considering requiring it to be a non-NULL argument, but right now it 
looks like we are safe).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
