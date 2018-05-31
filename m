Received: from eggs.gnu.org ([2001:4830:134:3::10]:46831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOOmb-0006wt-Dx
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOOmY-0002zA-A9
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:42:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57232 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fOOmY-0002y5-5Q
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:42:26 -0400
References: <20180531051641.8473-1-peterx@redhat.com>
	<20180531051641.8473-3-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ecd9d666-8973-3f09-0ab9-eea9655e5919@redhat.com>
Date: Thu, 31 May 2018 09:42:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180531051641.8473-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 2/4] tests: iotests: don't compare
 SHUTDOWN event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 05/31/2018 12:16 AM, Peter Xu wrote:
> This event is not really necessary.  After OOB series it might affect
> the timing of the script so this event may or may not be there comparing
> to the old *.out results.  Let's just filter it out.

This is worrying. Are you stating that the SHUTDOWN event can occur in a 
different order than it used to, or is it even worse that the SHUTDOWN 
event disappears altogether?  If enabling OOB makes the SHUTDOWN event 
sometimes disappear, that's a regression that we should fix.  If it just 
makes things occur in a different order, we need an explanation why that 
is okay.

> 
> Since some of the scripts are using qmp-pretty, we need some trick in
> the filtering script to make sure sed works for multiple lines to
> explicitly mask out this event.
> 
> CC: John Snow <jsnow@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

> +++ b/tests/qemu-iotests/067.out
> @@ -70,6 +70,7 @@ Testing: -drive file=TEST_DIR/t.IMGFMT,format=IMGFMT,if=none,id=disk -device vir
>       }
>   }
>   
> +
>   === -drive/device_add and device_del ===

Why is this blank line being added (multiple times in this file)?  Is 
there something about the new filter that isn't quite stripping all the 
newlines when encountering the SHUTDOWN event in pretty form?

Aha - it's because test 067 is already doing a very similar filtering of 
events.  Can we reduce the code duplication by promoting 
_filter_qmp_events from there into common.filter (as a separate patch)?

> +++ b/tests/qemu-iotests/common.filter
> @@ -88,7 +88,10 @@ _filter_qmp()
>       sed -e 's#\("\(micro\)\?seconds": \)[0-9]\+#\1 TIMESTAMP#g' \
>           -e 's#^{"QMP":.*}$#QMP_VERSION#' \
>           -e '/^    "QMP": {\s*$/, /^    }\s*$/ c\' \
> -        -e '    QMP_VERSION'
> +        -e '    QMP_VERSION' | \
> +    tr '\n' '\r' | \
> +    sed -e 's/{\s*"timestamp":\s*{\s*"seconds":\s*TIMESTAMP,\s*"microseconds":\s*TIMESTAMP\s*},\s*"event":\s*"SHUTDOWN",\s*"data":\s*{\s*"guest":\s*false\s*}\s*}\s//' | \

Really long line. This should do the same:

sed -e 's/\r{\(\r[^}]\|[^\r]\)*SHUTDOWN\(\r[^}]\|[^\r]\)*\r}//'

where the \(\r[^}]\|[^\r]\)* subpattern picks up all line breaks that do 
not end the current top-level {}, as well as any non-line breaks.

In fact, if you like my suggestion about promoting the filter from 67 
into common.filter, we have two use cases: filter a single 
pretty-printed filter, and filter ANY pretty-printed filter.  Maybe we 
do that as follows:

# $1 is a regex of event names to filter; leave empty to filter all
_filter_qmp_events()
{
     fluff='\(\r[^}]\|[^\r]\)*'
     tr \\n \\r | \
     sed -e "s/$fluff"'"event": "'"$1$fluff\\r}//" \
   | tr \\r \\n
}

at which point '_filter_qmp_events SHUTDOWN' works in this patch, and 
'_filter_qmp_events' works for 067.  [Untested, but hopefully that gives 
you some ideas to play with]

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
