Received: from eggs.gnu.org ([2001:4830:134:3::10]:38993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fEINv-0004j7-21
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fEINg-0001Gt-TG
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:51:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fEINg-0001Em-DH
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:51:00 -0400
Date: Thu, 3 May 2018 18:50:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180503175050.GM2660@work-vm>
References: <20180427173416.19233-1-dgilbert@redhat.com>
	<20180429143728.GA20847@9.122.211.20>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429143728.GA20847@9.122.211.20>
Subject: Re: [Qemu-devel] [PATCH v2] migration: update docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balamuruhan S <bala24@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

* Balamuruhan S (bala24@linux.vnet.ibm.com) wrote:
> On Fri, Apr 27, 2018 at 06:34:16PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Update the migration docs:


> > > Would you like to add a note about taking care of migrating drc states incase
> > > of hot adding devices, that could ensure hotunplug device safely after
> > > migration ?
> >
> > That's something Power specific as I understand, but I don't know any
> > details of it.  What would you say as a general warning ?
> 
> yes it is Power specific,
> 
> In migration hot added devices state might get changed in source and target
> will not be aware of it. This cause hotunplug of the devices in target after
> migration to fail. In PowerPC as per PAPR 13.4 Dynamic Reconfiguration
> Connector (DRC) provides way to interface and manage the dynamic resources
> of the guest. With Qemu commit a50919dddf148b0a, VMStateDescription struct
> spapr_drc is introduced to support the DRC states to migrate but for LMB,
> PCI and CPU devices, whereas PHB still doesn't have the support. So the
> implementation should take care of hotadded devices states during migration
> as it should not make the guest inconsistent after migration or when the device
> is hotunplugged after migration.

I think this is pretty Power specific, so is probably best in some Power
docs rather than the generic migration docs.
As far as I understand it, most other devices just have this state as
part of the state of PCI bridges etc.

Also, I think some of the DRC pain is historic with what was first
implemented and what state it evolved to, rather than being that
general.

Dave

> -- Bala
> > 
> >  VMState
> >  -------
> > 
> > -The legacy way of saving/loading state of the device had the problem
> > -that we have to maintain two functions in sync.  If we did one change
> > -in one of them and not in the other, we would get a failed migration.
> > -
> > -VMState changed the way that state is saved/loaded.  Instead of using
> > -a function to save the state and another to load it, it was changed to
> > -a declarative way of what the state consisted of.  Now VMState is able
> > -to interpret that definition to be able to load/save the state.  As
> > -the state is declared only once, it can't go out of sync in the
> > -save/load functions.
> > +Most device data can be described using the ``VMSTATE`` macros (mostly defined
> > +in ``include/migration/vmstate.h``).
> > 
> >  An example (from hw/input/pckbd.c)
> > 
> > @@ -137,103 +152,99 @@ We registered this with:
> > 
> >      vmstate_register(NULL, 0, &vmstate_kbd, s);
> > 
> > -Note: talk about how vmstate <-> qdev interact, and what the instance ids mean.
> > -
> > -You can search for ``VMSTATE_*`` macros for lots of types used in QEMU in
> > -include/hw/hw.h.
> > -
> > -More about versions
> > --------------------
> > -
> > -Version numbers are intended for major incompatible changes to the
> > -migration of a device, and using them breaks backwards-migration
> > -compatibility; in general most changes can be made by adding Subsections
> > -(see below) or _TEST macros (see below) which won't break compatibility.
> > -
> > -You can see that there are several version fields:
> > -
> > -- `version_id`: the maximum version_id supported by VMState for that device.
> > -- `minimum_version_id`: the minimum version_id that VMState is able to understand
> > -  for that device.
> > -- `minimum_version_id_old`: For devices that were not able to port to vmstate, we can
> > -  assign a function that knows how to read this old state. This field is
> > -  ignored if there is no `load_state_old` handler.
> > +For devices that are `qdev` based, we can register the device in the class
> > +init function:
> > 
> > -So, VMState is able to read versions from minimum_version_id to
> > -version_id.  And the function ``load_state_old()`` (if present) is able to
> > -load state from minimum_version_id_old to minimum_version_id.  This
> > -function is deprecated and will be removed when no more users are left.
> > +.. code:: c
> > 
> > -Saving state will always create a section with the 'version_id' value
> > -and thus can't be loaded by any older QEMU.
> > +    dc->vmsd = &vmstate_kbd_isa;
> > 
> > -Massaging functions
> > --------------------
> > +The VMState macros take care of ensuring that the device data section
> > +is formatted portably (normally big endian) and make some compile time checks
> > +against the types of the fields in the structures.
> > 
> > -Sometimes, it is not enough to be able to save the state directly
> > -from one structure, we need to fill the correct values there.  One
> > -example is when we are using kvm.  Before saving the cpu state, we
> > -need to ask kvm to copy to QEMU the state that it is using.  And the
> > -opposite when we are loading the state, we need a way to tell kvm to
> > -load the state for the cpu that we have just loaded from the QEMUFile.
> > +VMState macros can include other VMStateDescriptions to store substructures
> > +(see ``VMSTATE_STRUCT_``), arrays (``VMSTATE_ARRAY_``) and variable length
> > +arrays (``VMSTATE_VARRAY_``).  Various other macros exist for special
> > +cases.
> > 
> > -The functions to do that are inside a vmstate definition, and are called:
> > +Note that the format on the wire is still very raw; i.e. a VMSTATE_UINT32
> > +ends up with a 4 byte bigendian representation on the wire; in the future
> > +it might be possible to use a more structured format.
> > 
> > -- ``int (*pre_load)(void *opaque);``
> > +Legacy way
> > +----------
> > 
> > -  This function is called before we load the state of one device.
> > +This way is going to disappear as soon as all current users are ported to VMSTATE;
> > +although converting existing code can be tricky, and thus 'soon' is relative.
> > 
> > -- ``int (*post_load)(void *opaque, int version_id);``
> > +Each device has to register two functions, one to save the state and
> > +another to load the state back.
> > 
> > -  This function is called after we load the state of one device.
> > +.. code:: c
> > 
> > -- ``int (*pre_save)(void *opaque);``
> > +  int register_savevm_live(DeviceState *dev,
> > +                           const char *idstr,
> > +                           int instance_id,
> > +                           int version_id,
> > +                           SaveVMHandlers *ops,
> > +                           void *opaque);
> > 
> > -  This function is called before we save the state of one device.
> > +Two functions in the ``ops`` structure are the `save_state`
> > +and `load_state` functions.  Notice that `load_state` receives a version_id
> > +parameter to know what state format is receiving.  `save_state` doesn't
> > +have a version_id parameter because it always uses the latest version.
> > 
> > -Example: You can look at hpet.c, that uses the three function to
> > -massage the state that is transferred.
> > +Note that because the VMState macros still save the data in a raw
> > +format, in many cases it's possible to replace legacy code
> > +with a carefully constructed VMState description that matches the
> > +byte layout of the existing code.
> > 
> > -If you use memory API functions that update memory layout outside
> > -initialization (i.e., in response to a guest action), this is a strong
> > -indication that you need to call these functions in a `post_load` callback.
> > -Examples of such memory API functions are:
> > +Changing migration data structures
> > +----------------------------------
> > 
> > -  - memory_region_add_subregion()
> > -  - memory_region_del_subregion()
> > -  - memory_region_set_readonly()
> > -  - memory_region_set_enabled()
> > -  - memory_region_set_address()
> > -  - memory_region_set_alias_offset()
> > +When we migrate a device, we save/load the state as a series
> > +of fields.  Some times, due to bugs or new functionality, we need to
> > +change the state to store more/different information.  Changing the migration
> > +state saved for a device can break migration compatibility unless
> > +care is taken to use the appropriate techniques.  In general QEMU tries
> > +to maintain forward migration compatibility (i.e. migrating from
> > +QEMU n->n+1) and there are users who benefit from backward compatibility
> > +as well.
> > 
> >  Subsections
> >  -----------
> > 
> > -The use of version_id allows to be able to migrate from older versions
> > -to newer versions of a device.  But not the other way around.  This
> > -makes very complicated to fix bugs in stable branches.  If we need to
> > -add anything to the state to fix a bug, we have to disable migration
> > -to older versions that don't have that bug-fix (i.e. a new field).
> > -
> > -But sometimes, that bug-fix is only needed sometimes, not always.  For
> > -instance, if the device is in the middle of a DMA operation, it is
> > -using a specific functionality, ....
> > +The most common structure change is adding new data, e.g. when adding
> > +a newer form of device, or adding that state that you previously
> > +forgot to migrate.  This is best solved using a subsection.
> > 
> > -It is impossible to create a way to make migration from any version to
> > -any other version to work.  But we can do better than only allowing
> > -migration from older versions to newer ones.  For that fields that are
> > -only needed sometimes, we add the idea of subsections.  A subsection
> > -is "like" a device vmstate, but with a particularity, it has a Boolean
> > -function that tells if that values are needed to be sent or not.  If
> > -this functions returns false, the subsection is not sent.
> > +A subsection is "like" a device vmstate, but with a particularity, it
> > +has a Boolean function that tells if that values are needed to be sent
> > +or not.  If this functions returns false, the subsection is not sent.
> > +Subsections have a unique name, that is looked for on the receiving
> > +side.
> > 
> >  On the receiving side, if we found a subsection for a device that we
> >  don't understand, we just fail the migration.  If we understand all
> > -the subsections, then we load the state with success.
> > +the subsections, then we load the state with success.  There's no check
> > +that a subsection is loaded, so a newer QEMU that knows about a subsection
> > +can (with care) load a stream from an older QEMU that didn't send
> > +the subsection.
> > +
> > +If the new data is only needed in a rare case, then the subsection
> > +can be made conditional on that case and the migration will still
> > +succeed to older QEMUs in most cases.  This is OK for data that's
> > +critical, but in some use cases it's preferred that the migration
> > +should succeed even with the data missing.  To support this the
> > +subsection can be connected to a device property and from there
> > +to a versioned machine type.
> > 
> >  One important note is that the post_load() function is called "after"
> >  loading all subsections, because a newer subsection could change same
> > -value that it uses.
> > +value that it uses.  A flag, and the combination of pre_load and post_load
> > +can be used to detect whether a subsection was loaded, and to
> > +fall back on default behaviour when the subsection isn't present.
> > 
> >  Example:
> > 
> > @@ -288,9 +299,13 @@ save/send this state when we are in the middle of a pio operation
> >  not enabled, the values on that fields are garbage and don't need to
> >  be sent.
> > 
> > +Connecting subsections to properties
> > +------------------------------------
> > +
> >  Using a condition function that checks a 'property' to determine whether
> > -to send a subsection allows backwards migration compatibility when
> > -new subsections are added.
> > +to send a subsection allows backward migration compatibility when
> > +new subsections are added, especially when combined with versioned
> > +machine types.
> > 
> >  For example:
> > 
> > @@ -305,21 +320,7 @@ For example:
> > 
> >  Now that subsection will not be generated when using an older
> >  machine type and the migration stream will be accepted by older
> > -QEMU versions. pre-load functions can be used to initialise state
> > -on the newer version so that they default to suitable values
> > -when loading streams created by older QEMU versions that do not
> > -generate the subsection.
> > -
> > -In some cases subsections are added for data that had been accidentally
> > -omitted by earlier versions; if the missing data causes the migration
> > -process to succeed but the guest to behave badly then it may be better
> > -to send the subsection and cause the migration to explicitly fail
> > -with the unknown subsection error.   If the bad behaviour only happens
> > -with certain data values, making the subsection conditional on
> > -the data value (rather than the machine type) allows migrations to succeed
> > -in most cases.  In general the preference is to tie the subsection to
> > -the machine type, and allow reliable migrations, unless the behaviour
> > -from omission of the subsection is really bad.
> > +QEMU versions.
> > 
> >  Not sending existing elements
> >  -----------------------------
> > @@ -328,9 +329,12 @@ Sometimes members of the VMState are no longer needed:
> > 
> >    - removing them will break migration compatibility
> > 
> > -  - making them version dependent and bumping the version will break backwards migration compatibility.
> > +  - making them version dependent and bumping the version will break backward migration compatibility.
> > +
> > +Adding a dummy field into the migration stream is normally the best way to preserve
> > +compatibility.
> > 
> > -The best way is to:
> > +If the field really does need to be removed then:
> > 
> >    a) Add a new property/compatibility/function in the same way for subsections above.
> >    b) replace the VMSTATE macro with the _TEST version of the macro, e.g.:
> > @@ -342,18 +346,208 @@ The best way is to:
> >     ``VMSTATE_UINT32_TEST(foo, barstruct, pre_version_baz)``
> > 
> >     Sometime in the future when we no longer care about the ancient versions these can be killed off.
> > +   Note that for backward compatibility it's important to fill in the structure with
> > +   data that the destination will understand.
> > +
> > +Any difference in the predicates on the source and destination will end up
> > +with different fields being enabled and data being loaded into the wrong
> > +fields; for this reason conditional fields like this are very fragile.
> > +
> > +Versions
> > +--------
> > +
> > +Version numbers are intended for major incompatible changes to the
> > +migration of a device, and using them breaks backward-migration
> > +compatibility; in general most changes can be made by adding Subsections
> > +(see above) or _TEST macros (see above) which won't break compatibility.
> > +
> > +Each version is associated with a series of fields saved.  The `save_state` always saves
> > +the state as the newer version.  But `load_state` sometimes is able to
> > +load state from an older version.
> > +
> > +You can see that there are several version fields:
> > +
> > +- `version_id`: the maximum version_id supported by VMState for that device.
> > +- `minimum_version_id`: the minimum version_id that VMState is able to understand
> > +  for that device.
> > +- `minimum_version_id_old`: For devices that were not able to port to vmstate, we can
> > +  assign a function that knows how to read this old state. This field is
> > +  ignored if there is no `load_state_old` handler.
> > +
> > +VMState is able to read versions from minimum_version_id to
> > +version_id.  And the function ``load_state_old()`` (if present) is able to
> > +load state from minimum_version_id_old to minimum_version_id.  This
> > +function is deprecated and will be removed when no more users are left.
> > +
> > +There are *_V* forms of many ``VMSTATE_`` macros to load fields for version dependent fields,
> > +e.g.
> > +
> > +.. code:: c
> > +
> > +   VMSTATE_UINT16_V(ip_id, Slirp, 2),
> > +
> > +only loads that field for versions 2 and newer.
> > +
> > +Saving state will always create a section with the 'version_id' value
> > +and thus can't be loaded by any older QEMU.
> > +
> > +Massaging functions
> > +-------------------
> > +
> > +Sometimes, it is not enough to be able to save the state directly
> > +from one structure, we need to fill the correct values there.  One
> > +example is when we are using kvm.  Before saving the cpu state, we
> > +need to ask kvm to copy to QEMU the state that it is using.  And the
> > +opposite when we are loading the state, we need a way to tell kvm to
> > +load the state for the cpu that we have just loaded from the QEMUFile.
> > +
> > +The functions to do that are inside a vmstate definition, and are called:
> > +
> > +- ``int (*pre_load)(void *opaque);``
> > +
> > +  This function is called before we load the state of one device.
> > +
> > +- ``int (*post_load)(void *opaque, int version_id);``
> > +
> > +  This function is called after we load the state of one device.
> > +
> > +- ``int (*pre_save)(void *opaque);``
> > +
> > +  This function is called before we save the state of one device.
> > +
> > +Example: You can look at hpet.c, that uses the three function to
> > +massage the state that is transferred.
> > +
> > +The ``VMSTATE_WITH_TMP`` macro may be useful when the migration
> > +data doesn't match the stored device data well; it allows an
> > +intermediate temporary structure to be populated with migration
> > +data and then transferred to the main structure.
> > +
> > +If you use memory API functions that update memory layout outside
> > +initialization (i.e., in response to a guest action), this is a strong
> > +indication that you need to call these functions in a `post_load` callback.
> > +Examples of such memory API functions are:
> > +
> > +  - memory_region_add_subregion()
> > +  - memory_region_del_subregion()
> > +  - memory_region_set_readonly()
> > +  - memory_region_set_enabled()
> > +  - memory_region_set_address()
> > +  - memory_region_set_alias_offset()
> > +
> > +Iterative device migration
> > +--------------------------
> > +
> > +Some devices, such as RAM, Block storage or certain platform devices,
> > +have large amounts of data that would mean that the CPUs would be
> > +paused for too long if they were sent in one section.  For these
> > +devices an *iterative* approach is taken.
> > +
> > +The iterative devices generally don't use VMState macros
> > +(although it may be possible in some cases) and instead use
> > +qemu_put_*/qemu_get_* macros to read/write data to the stream.  Specialist
> > +versions exist for high bandwidth IO.
> > +
> > +
> > +An iterative device must provide:
> > +
> > +  - A ``save_setup`` function that initialises the data structures and
> > +    transmits a first section containing information on the device.  In the
> > +    case of RAM this transmits a list of RAMBlocks and sizes.
> > +
> > +  - A ``load_setup`` function that initialises the data structures on the
> > +    destination.
> > +
> > +  - A ``save_live_pending`` function that is called repeatedly and must
> > +    indicate how much more data the iterative data must save.  The core
> > +    migration code will use this to determine when to pause the CPUs
> > +    and complete the migration.
> > +
> > +  - A ``save_live_iterate`` function (called after ``save_live_pending``
> > +    when there is significant data still to be sent).  It should send
> > +    a chunk of data until the point that stream bandwidth limits tell it
> > +    to stop.  Each call generates one section.
> > +
> > +  - A ``save_live_complete_precopy`` function that must transmit the
> > +    last section for the device containing any remaining data.
> > +
> > +  - A ``load_state`` function used to load sections generated by
> > +    any of the save functions that generate sections.
> > +
> > +  - ``cleanup`` functions for both save and load that are called
> > +    at the end of migration.
> > +
> > +Note that the contents of the sections for iterative migration tend
> > +to be open-coded by the devices; care should be taken in parsing
> > +the results and structuring the stream to make them easy to validate.
> > +
> > +Device ordering
> > +---------------
> > +
> > +There are cases in which the ordering of device loading matters; for
> > +example in some systems where a device may assert an interrupt during loading,
> > +if the interrupt controller is loaded later then it might lose the state.
> > +
> > +Some ordering is implicitly provided by the order in which the machine
> > +definition creates devices, however this is somewhat fragile.
> > +
> > +The ``MigrationPriority`` enum provides a means of explicitly enforcing
> > +ordering.  Numerically higher priorities are loaded earlier.
> > +The priority is set by setting the ``priority`` field of the top level
> > +``VMStateDescription`` for the device.
> > +
> > +Stream structure
> > +================
> > +
> > +The stream tries to be word and endian agnostic, allowing migration between hosts
> > +of different characteristics running the same VM.
> > +
> > +  - Header
> > +
> > +    - Magic
> > +    - Version
> > +    - VM configuration section
> > +
> > +       - Machine type
> > +       - Target page bits
> > +  - List of sections
> > +    Each section contains a device, or one iteration of a device save.
> > +
> > +    - section type
> > +    - section id
> > +    - ID string (First section of each device)
> > +    - instance id (First section of each device)
> > +    - version id (First section of each device)
> > +    - <device data>
> > +    - Footer mark
> > +  - EOF mark
> > +  - VM Description structure
> > +    Consisting of a JSON description of the contents for analysis only
> > +
> > +The ``device data`` in each section consists of the data produced
> > +by the code described above.  For non-iterative devices they have a single
> > +section; iterative devices have an initial and last section and a set
> > +of parts in between.
> > +Note that there is very little checking by the common code of the integrity
> > +of the ``device data`` contents, that's up to the devices themselves.
> > +The ``footer mark`` provides a little bit of protection for the case where
> > +the receiving side reads more or less data than expected.
> > +
> > +The ``ID string`` is normally unique, having been formed from a bus name
> > +and device address, PCI devices and storage devices hung off PCI controllers
> > +fit this pattern well.  Some devices are fixed single instances (e.g. "pc-ram").
> > +Others (especially either older devices or system devices which for
> > +some reason don't have a bus concept) make use of the ``instance id``
> > +for otherwise identically named devices.
> > 
> >  Return path
> >  -----------
> > 
> > -In most migration scenarios there is only a single data path that runs
> > -from the source VM to the destination, typically along a single fd (although
> > -possibly with another fd or similar for some fast way of throwing pages across).
> > -
> > -However, some uses need two way communication; in particular the Postcopy
> > -destination needs to be able to request pages on demand from the source.
> > +Only a unidirectional stream is required for normal migration, however a
> > +``return path`` can be created when bidirectional communication is desired.
> > +This is primarily used by postcopy, but is also used to return a success
> > +flag to the source at the end of migration.
> > 
> > -For these scenarios there is a 'return path' from the destination to the source;
> >  ``qemu_file_get_return_path(QEMUFile* fwdpath)`` gives the QEMUFile* for the return
> >  path.
> > 
> > @@ -632,3 +826,28 @@ Retro-fitting postcopy to existing clients is possible:
> >       identified and the implication understood; for example if the
> >       guest memory access is made while holding a lock then all other
> >       threads waiting for that lock will also be blocked.
> > +
> > +Firmware
> > +========
> > +
> > +Migration migrates the copies of RAM and ROM, and thus when running
> > +on the destination it includes the firmware from the source. Even after
> > +resetting a VM, the old firmware is used.  Only once QEMU has been restarted
> > +is the new firmware in use.
> > +
> > +- Changes in firmware size can cause changes in the required RAMBlock size
> > +  to hold the firmware and thus migration can fail.  In practice it's best
> > +  to pad firmware images to convenient powers of 2 with plenty of space
> > +  for growth.
> > +
> > +- Care should be taken with device emulation code so that newer
> > +  emulation code can work with older firmware to allow forward migration.
> > +
> > +- Care should be taken with newer firmware so that backward migration
> > +  to older systems with older device emulation code will work.
> > +
> > +In some cases it may be best to tie specific firmware versions to specific
> > +versioned machine types to cut down on the combinations that will need
> > +support.  This is also useful when newer versions of firmware outgrow
> > +the padding.
> > +
> > -- 
> > 2.17.0
> > 
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
