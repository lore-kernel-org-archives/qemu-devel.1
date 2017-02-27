Received: from eggs.gnu.org ([2001:4830:134:3::10]:45523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciUDg-0007RE-E5
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciUDf-0002IF-AJ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:56:40 -0500
Date: Mon, 27 Feb 2017 17:56:31 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170227225631.GM25637@localhost.localdomain>
References: <cover.1488220970.git.jcody@redhat.com>
	<fa6a26e1642ad7e593f3a0776a4a021997493f24.1488220970.git.jcody@redhat.com>
	<4b9a328b-5537-d06d-3510-d2d4038347a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b9a328b-5537-d06d-3510-d2d4038347a3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] block/rbd: parse all options via
 bdrv_parse_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com

On Mon, Feb 27, 2017 at 04:35:58PM -0600, Eric Blake wrote:
> On 02/27/2017 12:58 PM, Jeff Cody wrote:
> > Get rid of qemu_rbd_parsename in favor of bdrv_parse_filename.
> > This simplifies a lot of the parsing as well, as we can treat everything
> > a bit simpler since nonexistent options are simply NULL pointers instead
> > of empy strings.
> 
> s/empy/empty/
>

Thanks

> > 
> > An important item to note:
> > 
> > Ceph has many extra option values that can be specified as key/value
> > pairs.  This was handled previously in the driver by extracting the
> > values that the QEMU driver cared about, and then blindly passing all
> > extra options to rbd after splitting them into key/value pairs, and
> > cleaning up any special character escaping.
> > 
> > The practice is continued in this patch; there is an option
> > "keyvalue-pairs" that is populated with all the key/value pairs that the
> > QEMU driver does not care about.  These key/value pairs will override
> > any settings in the 'conf' configuration file, just as they did before.
> > 
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  block/rbd.c | 298 ++++++++++++++++++++++++++++++------------------------------
> >  1 file changed, 148 insertions(+), 150 deletions(-)
> > 
> 
> > +
> > +    /* The following are essentially all key/value pairs, and we treat
> > +     * 'id' and 'conf' a bit special.  Key/value pairs may be in any order. */
> > +    while (p) {
> 
> > +        if (!strcmp(name, "conf")) {
> > +            qdict_put(options, "conf", qstring_from_str(value));
> > +        } else if (!strcmp(name, "id")) {
> > +            qdict_put(options, "user" , qstring_from_str(value));
> > +        } else {
> > +            char *tmp = g_malloc0(max_keypair_size);
> > +            /* only use a delimiter if it is not the first keypair found */
> > +            /* These are sets of unknown key/value pairs we'll pass along
> > +             * to ceph */
> > +            if (keypairs[0]) {
> > +                snprintf(tmp, max_keypair_size, ":%s=%s", name, value);
> > +                pstrcat(keypairs, max_keypair_size, tmp);
> > +            } else {
> > +                snprintf(keypairs, max_keypair_size, "%s=%s", name, value);
> > +            }
> > +            g_free(tmp);
> > +        }
> > +    }
> > +
> > +    if (keypairs[0]) {
> > +        qdict_put(options, "keyvalue-pairs", qstring_from_str(keypairs));
> 
> Uggh.  Why are we compressing this into a single string, instead of
> using a GList?  True, we aren't exposing it through QAPI, but I still
> wonder if a smarter representation than a flat string is warranted.
> 

Yes, a bit gross.  I wouldn't mind cleaning it up (and maybe some other rbd
cleanup as well), but for this series I wanted to keep the "other" parsing
the same as before, and just try to (as much as possible) layer the
blockdev-add QAPI on top.

As you suggest below, I'll add a 'FIXME' here detailing that this is left in
place as legacy code, and should be cleaned up into something more palatable
like a GList (or at least _some_ sort of structured data).

> > @@ -434,35 +421,55 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
> >      if (objsize) {
> >          if ((objsize - 1) & objsize) {    /* not a power of 2? */
> 
> Drive-by comment (if you fix it, do it as a separate followup patch): we
> have is_power_of_2() to make code like this more legible.
>

I'll add that to my post 2.9 rbd cleanup queue, thanks.

> >  
> >  static BlockDriver bdrv_rbd = {

> > -    .instance_size      = sizeof(BDRVRBDState),
> > -    .bdrv_needs_filename = true,
> > -    .bdrv_file_open     = qemu_rbd_open,
> > -    .bdrv_close         = qemu_rbd_close,
> > -    .bdrv_create        = qemu_rbd_create,
> > -    .bdrv_has_zero_init = bdrv_has_zero_init_1,
> > -    .bdrv_get_info      = qemu_rbd_getinfo,
> > -    .create_opts        = &qemu_rbd_create_opts,
> > -    .bdrv_getlength     = qemu_rbd_getlength,
> > -    .bdrv_truncate      = qemu_rbd_truncate,
> > -    .protocol_name      = "rbd",
> > +    .format_name            = "rbd",
> > +    .instance_size          = sizeof(BDRVRBDState),
> > +    .bdrv_parse_filename    = qemu_rbd_parse_filename,
> > +    .bdrv_file_open         = qemu_rbd_open,
> > +    .bdrv_close             = qemu_rbd_close,
> > +    .bdrv_create            = qemu_rbd_create,
> > +    .bdrv_has_zero_init     = bdrv_has_zero_init_1,
> > +    .bdrv_get_info          = qemu_rbd_getinfo,
> > +    .create_opts            = &qemu_rbd_create_opts,
> 
> Pointless &; might as well remove it for consistency while touching it.
> 

I'm not sure I understand - we need the '&' here for the .create_opts
initializer, unless I am overlooking something.

> > +    .bdrv_getlength         = qemu_rbd_getlength,
> > +    .bdrv_truncate          = qemu_rbd_truncate,
> > +    .protocol_name          = "rbd",
> >  
> 
> I don't know if it is worth respinning to change keyvalue-pairs into a
> more appropriate data type; given our desire to make blockdev-add stable
> for 2.9 and the fact that keyvalue-pairs is not exposed to QAPI, I can
> live with passing around a flat string.  You may want to add FIXME
> comments to call attention to the fact that we know it is gross but why
> we do it anyways.
>
> But since adding comments, and fixing minor things like &, doesn't
> change the real meat of this patch, I can live with:
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thanks!

-Jeff
