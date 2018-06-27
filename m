Received: from eggs.gnu.org ([2001:4830:134:3::10]:59494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYAbl-0007sk-9s
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYAbg-0004jQ-3O
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:35:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYAbf-0004he-D9
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:35:35 -0400
Date: Wed, 27 Jun 2018 10:34:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180627133449.GW7451@localhost.localdomain>
References: <20180627021423.18404-1-ehabkost@redhat.com>
	<20180627021423.18404-7-ehabkost@redhat.com>
	<6c6da5dd-0ab4-b4c4-9411-169f9dfbbdfc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c6da5dd-0ab4-b4c4-9411-169f9dfbbdfc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/6] docker: Open dockerfiles in text mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>

On Wed, Jun 27, 2018 at 07:51:01AM -0500, Eric Blake wrote:
> On 06/26/2018 09:14 PM, Eduardo Habkost wrote:
> > Instead of treating dockerfile contents as byte sequences, always
> > open dockerfiles in text mode and treat it as text.
> > 
> > This is not strictly required to make the script compatible with
> > Python 3, but it's a simpler and safer way than opening
> > dockerfiles in binary mode and decoding the data data later.
> 
> s/data data/data/

Thanks.

> 
> > 
> > To make the code compatible with both Python 2 and 3, use
> > io.open(), which accepts a 'encoding' argument on both versions.
> 
> How does this compare to the recent change to the QAPI generators in commit
> de685ae5e?  Should we be trying to use similar mechanisms in both places?

We could do the same and use io.open(..., encoding='utf-8')
unconditionally on QAPI too, but it may be harder because of its
usage of insinstance() and the 'str' type[1] everywhere.

One solution I considered on QAPI was using
'__future__.unicode_literals' and the 'builtins.str' type from
python-future, but I don't think QAPI's specific case justify
adding a new build dependency on Python 2.7 hosts.

Adding type annotations to the QAPI code may help us sort out the
mess more easily.

[1] 'str' on Python 2.7 is more similar to the 'bytes' type on
    Python 3, but io.open(..., encoding=...) on Python 2.7
    returns 'unicode' objects (that that are more similar to the
    native 'str' type from Python 3).

-- 
Eduardo
