Received: from eggs.gnu.org ([2001:4830:134:3::10]:55862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cq1gT-0001oq-Jf
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 14:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cq1gQ-0001fl-G4
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 14:05:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cq1gQ-0001fV-9s
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 14:05:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 256147E9C9
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 18:05:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170320173840.3626-2-dgilbert@redhat.com> (David Alan Gilbert's
	message of "Mon, 20 Mar 2017 17:38:39 +0000")
References: <20170320173840.3626-1-dgilbert@redhat.com>
	<20170320173840.3626-2-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 20 Mar 2017 19:05:26 +0100
Message-ID: <87d1dbj02h.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] save_vmstate: Convert to Error** from
 Monitor *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, kraxel@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> A bit more consistent and it removes one of the less necessary uses
> of cur_mon.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> @@ -2094,16 +2094,17 @@ int save_vmstate(Monitor *mon, const char *name)
>      if (name) {
>          ret = bdrv_all_delete_snapshot(name, &bs1, &local_err);
>          if (ret < 0) {
> -            error_reportf_err(local_err,
> -                              "Error while deleting snapshot on device '%s': ",
> -                              bdrv_get_device_name(bs1));
> +            error_propagate(errp, local_err);
> +            error_prepend(errp,
> +                          "Error while deleting snapshot on device '%s': ",
> +                          bdrv_get_device_name(bs1));

This is just magic O:-)
