Received: from eggs.gnu.org ([209.51.188.92]:43511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJZ1Q-00023R-QC
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJYxM-0007Bp-A6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:38:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hJYxM-0007AE-0Q
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:38:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CBA63003B45
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:38:05 +0000 (UTC)
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<2b1d825f-8bd3-ba25-3e1b-8415aeec8ce6@redhat.com>
	<20190424181049.GF18406@habkost.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f8b5a75c-c7de-a6d8-83d7-c3ba2a0cbaf8@redhat.com>
Date: Thu, 25 Apr 2019 09:38:00 +0200
MIME-Version: 1.0
In-Reply-To: <20190424181049.GF18406@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Export machine type deprecation info
 through QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: mprivozn@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 24/04/2019 20.10, Eduardo Habkost wrote:
> On Wed, Apr 24, 2019 at 09:56:53AM +0200, Thomas Huth wrote:
>> On 23/04/2019 23.22, Eduardo Habkost wrote:
>>> This series adds machine type deprecation information to the
>>> output of the `query-machines` QMP command.  With this, libvirt
>>> and management software will be able to show this information to
>>> users and/or suggest changes to VM configuration to avoid
>>> deprecated machine types.
>>>
>>> Eduardo Habkost (3):
>>>   qapi: SupportStatusInfo struct
>>>   machine: Use SupportStatusInfo for deprecation info
>>>   qmp: Add deprecation information to query-machines
>>>
>>>  qapi/common.json                   | 24 ++++++++++++++++++++++++
>>>  qapi/misc.json                     |  5 ++++-
>>>  include/hw/boards.h                |  7 ++++---
>>>  hw/i386/pc_piix.c                  |  4 +++-
>>>  hw/ppc/prep.c                      |  4 +++-
>>>  vl.c                               | 19 +++++++++++++++----
>>>  tests/acceptance/query_machines.py | 27 +++++++++++++++++++++++++++
>>>  7 files changed, 80 insertions(+), 10 deletions(-)
>>>  create mode 100644 tests/acceptance/query_machines.py
>>
>> Good idea, but some questions come to my mind:
>>
>> - What about devices? IIRC Gerd wrote a patch series last year that do=
es
>>   something similar for devices... It would be good to synchronize the
>>   work, so that we do not have two completely interfaces between devic=
es
>>   and machines here in the end...
>=20
> My plan is to support this on devices, too.  I even had a version
> where documentation of SupportStatusInfo mentioned device types,
> but I decided to leave that out until we actually implement a
> device deprecation info API.
>=20
>>
>> - Is deprecation as a status enough, or do we want to carry more
>>   information here? E.g. is the machine maintained or orphan? Is it
>>   stable or rather experimental? And didn't Gerd have also some
>>   patches for this last year? ... yes, I think it was this series here=
:
>>   http://lists.gnu.org/archive/html/qemu-ppc/2018-11/msg00039.html
>>   ... actually, I like that idea with QemuSupportState... maybe you
>>   could base your work on that series instead?
>=20
> We might want to carry more information eventually.  The
> possibility of extending the data later is the main reason I
> called the struct SupportStatusInfo and not just DeprecationInfo.

Ok. I was just a little bit afraid that we define an interface here that
we have to change again completely once we want to carry more
information. For example whether "deprecated" should be a "bool" here,
or rather one of the "enum" entries like in Gerd's series. But after
reading through https://patchwork.kernel.org/patch/10660677/ again, I
think I agree that "deprecated" is orthogonal to the support state, e.g.
a device could still be supported (in the sense that there is a
maintainer for it), while it has been marked as "deprecated" already.
So no more objections from my side here.

 Thomas
