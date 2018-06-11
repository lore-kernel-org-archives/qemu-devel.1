Received: from eggs.gnu.org ([2001:4830:134:3::10]:43158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSLWL-0003X7-7s
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSLWH-0004Gh-B8
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:02:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58572 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSLWH-0004FX-6a
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:01:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A6BC80401A8
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 12:01:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-6-dgilbert@redhat.com>
Date: Mon, 11 Jun 2018 14:01:52 +0200
In-Reply-To: <20180608130846.22234-6-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 8 Jun 2018 14:08:44 +0100")
Message-ID: <87y3flilan.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, imammedo@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Allow a bunch of the info commands to be used in preconfig.
>
> version, chardev, name, uuid,memdev, iothreads
>   Were enabled in QMP in the previous patch from Igor

Yes, these are okay together with PATCH 4.

> status, hotpluggable_cpus
>   Was enabled in the original allow-preconfig series

query-status looks okay to me.

> history
>   is HMP specific

Yes.

> usbhost, qom-tree, numa
>   Don't have a QMP equivalent

HMP commands without a QMP equivalent are okay if their functionality
makes no sense in QMP, or is of use only for human users.

Example for "makes no sense in QMP": setting the current CPU, because a
QMP monitor doesn't have a current CPU.

Examples for "is of use only for human users": HMP command "help", the
integrated pocket calculator.

Now let's review the three commands:

* Gerd, why does "info usbhost" have no QMP equivalent?

* Eduardo, why does "info numa" have no QMP equivalent?

* "info qom-tree" is a recursive variant of qom-list that skips anything
  but children.  This convenience command exists so you don't have to
  filter and string together output from many qom-list.

  I think it stands to reason that if providing "info qom-tree" makes
  sense, then so does qom-list (HMP and QMP).  If qom-list, then
  qom-list-types, qom-list-properties, qom-get, and probably even
  qom-set (I've always been suspicious of qom-set, but that has nothing
  to do with preconfig state).

  It might make sense to split off the whole QOM shebang into a separate
  patch.

> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
