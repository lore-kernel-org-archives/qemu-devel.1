Received: from eggs.gnu.org ([2001:4830:134:3::10]:34659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gaRAw-0007Dq-Pc
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gaRAv-0002ob-03
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:13:38 -0500
References: <20181221093529.23855-1-jsnow@redhat.com>
	<20181221093529.23855-10-jsnow@redhat.com>
	<785c6911-3871-2fc0-d7ea-b09246fb9f1d@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <45e11a42-da20-9998-574c-e88fc802918a@redhat.com>
Date: Fri, 21 Dec 2018 15:13:28 -0500
MIME-Version: 1.0
In-Reply-To: <785c6911-3871-2fc0-d7ea-b09246fb9f1d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 09/11] iotests: change qmp_log filters
 to expect QMP objects only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 12/21/18 7:41 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hmm. This made me check, is enumerate applicable to dicts,
> and, yes it is.
> 

enumerate on dicts gives you a numerical index paired with the key,
so... k is the numerical index and v is the key.

> so, it may be as easy as
> 
>      for k, v in enumerate(qmsg):
>          if isinstance(v, list) or isinstance(v, dict):
>              qmsg[k] = filter_qmp(v, filter_fn)

                    ^ this will break if qmsg was a dict.

>          else:
>              qmsg[k] = filter_fn(k, v)
> 
> with this:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> 
> But does it what you want?
> So, for lists of strings, filter_fn will get pair of index in array
> and value?
> On the other hand, we can adjust the behavior as we want when we introduce
> such filters.

I'm not sure what I want...

Named index is the best, but isn't always available because like you
say, the object we are passed is not always a dictionary. We could
theoretically have a list of lists somewhere. What key would I pass
then? It's meaningless.

I could change qmp_filter to pass the k,v to the filter when it finds
the "last dictionary," i.e. if it recursively finds no more dictionaries
underneath, it passes the value along regardless of whatever it finds.
This is a bit more complex because I think I'd need a co-mutual
recursive function to "travel" each value and report if there are
further dictionaries down below.

Or, I could just leave the filter as-is where it only ever gets one,
non-dict/non-list item and receives a key. Sometimes the key will now be
a numerical index which is likely not useful...

I might stage this as-is for now. Let's revisit it before 4.0 rc0.

--js
