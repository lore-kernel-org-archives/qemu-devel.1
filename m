Received: from eggs.gnu.org ([209.51.188.92]:36872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gr1ir-0008Tc-I0
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gr1iq-0002UK-E4
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:29:13 -0500
Date: Tue, 5 Feb 2019 15:28:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190205142855.GD5273@linux.fritz.box>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<87pnsbxsi7.fsf@dusky.pond.sub.org>
	<20190204094621.GB5855@linux.fritz.box>
	<87d0o7psz6.fsf@dusky.pond.sub.org>
	<b448da30-7e0d-98be-d3dc-578fffc55de8@virtuozzo.com>
	<20190205100039.GC5273@linux.fritz.box>
	<8bdd3e6e-f83f-e73a-6dad-870d05698334@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bdd3e6e-f83f-e73a-6dad-870d05698334@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Markus Armbruster <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>

Am 05.02.2019 um 14:16 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 05.02.2019 13:00, Kevin Wolf wrote:
> > Am 04.02.2019 um 16:36 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> 04.02.2019 16:45, Markus Armbruster wrote:
> >>> Kevin Wolf <kwolf@redhat.com> writes:
> >>>
> >>>> Am 01.02.2019 um 19:39 hat Markus Armbruster geschrieben:
> >>>>> Andrey Shinkevich <andrey.shinkevich@virtuozzo.com> writes:
> >>>>>
> >>>>>> In the 'Format specific information' section of the 'qemu-img info'
> >>>>>> command output, the supplemental information about existing QCOW2
> >>>>>> bitmaps will be shown, such as a bitmap name, flags and granularity:
> >>>>>>
> >>>>>> image: /vz/vmprivate/VM1/harddisk.hdd
> >>>>>> file format: qcow2
> >>>>>> virtual size: 64G (68719476736 bytes)
> >>>>>> disk size: 3.0M
> >>>>>> cluster_size: 1048576
> >>>>>> Format specific information:
> >>>>>>       compat: 1.1
> >>>>>>       lazy refcounts: true
> >>>>>>       bitmaps:
> >>>>>>           [0]:
> >>>>>>               flags:
> >>>>>>                   [0]: in-use
> >>>>>>                   [1]: auto
> >>>>>>               name: back-up1
> >>>>>>               unknown flags: 4
> >>>>>>               granularity: 65536
> >>>>>>           [1]:
> >>>>>>               flags:
> >>>>>>                   [0]: in-use
> >>>>>>                   [1]: auto
> >>>>>>               name: back-up2
> >>>>>>               unknown flags: 8
> >>>>>>               granularity: 65536
> >>>>>>       refcount bits: 16
> >>>>>>       corrupt: false
> >>>>>>
> >>>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> >>>>>> ---
> >>>>> [...]
> >>>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >>>>>> index 91685be..271e0df 100644
> >>>>>> --- a/qapi/block-core.json
> >>>>>> +++ b/qapi/block-core.json
> >>>>>> @@ -69,6 +69,8 @@
> >>>>>>    # @encrypt: details about encryption parameters; only set if image
> >>>>>>    #           is encrypted (since 2.10)
> >>>>>>    #
> >>>>>> +# @bitmaps: A list of qcow2 bitmap details (since 4.0)
> >>>>>> +#
> >>>>>>    # Since: 1.7
> >>>>>>    ##
> >>>>>>    { 'struct': 'ImageInfoSpecificQCow2',
> >>>>>> @@ -77,7 +79,8 @@
> >>>>>>          '*lazy-refcounts': 'bool',
> >>>>>>          '*corrupt': 'bool',
> >>>>>>          'refcount-bits': 'int',
> >>>>>> -      '*encrypt': 'ImageInfoSpecificQCow2Encryption'
> >>>>>> +      '*encrypt': 'ImageInfoSpecificQCow2Encryption',
> >>>>>> +      '*bitmaps': ['Qcow2BitmapInfo']
> >>>>>>      } }
> >>>>>>    
> >>>>>>    ##
> >>>>>> @@ -454,6 +457,41 @@
> >>>>>>               'status': 'DirtyBitmapStatus'} }
> >>>>>>    
> >>>>>>    ##
> >>>>>> +# @Qcow2BitmapInfoFlags:
> >>>>>> +#
> >>>>>> +# An enumeration of flags that a bitmap can report to the user.
> >>>>>> +#
> >>>>>> +# @in-use: The bitmap was not saved correctly and may be inconsistent.
> >>>>>
> >>>>> I doubt the casual reader could guess the meaning from the name.  What
> >>>>> about @dirty?
> >>>>
> >>>> Feels like overloading the word "dirty" in the context of "dirty
> >>>> bitmaps". This might easily lead to misinterpretation as "this bitmap
> >>>> marks some clusters as dirty" rather than "this bitmap might be
> >>>> inconsistent".
> >>>
> >>> Call it @possibly-inconsistent then?
> >>>
> >>
> >> If you run qmp query-block while vm is running, all bitmaps in image will
> >> be in use. And in this context, in-use seems more appropriate than
> >> possibly-inconsistent. And in-use has less interference with the fact that
> >> actual bitmaps now are in-RAM BdrvDirtyBitmap structures which are actually
> >> consistent (and also shown by query-block)
> > 
> > Good point, but then this description isn't correct either:
> > 
> >      @in-use: The bitmap was not saved correctly and may be inconsistent.
> > 
> > Maybe what needs to change is the description, not the name?
> > 
> > Kevin
> > 
> 
> How about the following:
> 
> @in-use: This flag is set while bitmap is in use by software and it's data in
> qcow2 image may be out of date when actual bitmap data is managed by software.
> Presence of this flag in offline image means that bitmap was not saved correctly
> after last usage and it's data may be inconsistent.

Yes, I think this has the information it needs to have.

It needs some spelling and grammar fixes, but before I make them, I'll
wait if Eric would phrase it in a different way that sounds more natural
to him as a native speaker.

Kevin
