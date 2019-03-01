Received: from eggs.gnu.org ([209.51.188.92]:33151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzkyE-0001if-DC
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzkyD-0000zu-K7
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:25:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gzkyD-0000zA-Bc
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:25:09 -0500
References: <20190301154051.23317-1-armbru@redhat.com>
	<20190301154051.23317-8-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fa36fa5d-0df1-7108-1c26-0c6168e85828@redhat.com>
Date: Fri, 1 Mar 2019 10:25:07 -0600
MIME-Version: 1.0
In-Reply-To: <20190301154051.23317-8-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] qapi: Fix array first used in a
 different module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, quintela@redhat.com

On 3/1/19 9:40 AM, Markus Armbruster wrote:
> We generally put implicitly defined types in whatever module triggered
> their definition.  This is wrong for array types, as the included test
> case demonstrates.  Let's have a closer look at it.
> 
> Type 'Status' is defined sub-sub-module.json.  Array type ['Status']
> occurs in main module qapi-schema-test.json and in
> include/sub-module.json.  The main module's use is first, so the array
> type gets put into the main module.
> 
> The generated C headers define StatusList in qapi-types.h.  But
> include/qapi-types-sub-module.h uses it without including
> qapi-types.h.  Oops.
> 
> To fix that, put the array type into its element type's module.
> 
> Now StatusList gets generated into qapi-types-sub-module.h, which all
> its users include.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Yay! One less hack in .qapi files where we had to use dummy structs to
work around awkward declaration locations.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
